Return-Path: <netdev+bounces-150489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578ED9EA6AC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740BC1887E5D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F31ACECB;
	Tue, 10 Dec 2024 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yonfa6r2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D4198A37
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801510; cv=none; b=dzd6R4CJ5DmdFVBy2Hmt9oPp8bG4GjO/RC0N6kSeIG2Qpnmm0l29/nMMtSeYUVuzFEeXW3cGQyeOgWx63HX2sc8IfetxU/sKyNoYqJfWHqF0Y7QJ1mBYh+9qiS5+oazdraiQXOcElf/rudFjWpjSyql5TqAlh9fWF9ggx6abbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801510; c=relaxed/simple;
	bh=FNzKszCuHp8YBw4zUen9q+/Su0cHKgEr5TQylNKG7Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjK/4CcA17nKstnTiRDiqnAdPEF2h7lKQ4U3uc71NVpwlTqiCUvWAZP6Z8aP7ujoOp0kfez3UdfxzAgq2+VGbKkcoKqMLyjNUiZuHz9fVItB3h53JAE0DF5U6rFv63U7IwVlDqYnnECy1ydr6LBDpGy0Vt3H5vhgmmldyumuwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yonfa6r2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21625b4f978so29775ad.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733801508; x=1734406308; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vv0YJOP4wsTr0yQs0O9EirzGuPC4EYUuQmTwZ8ZwYDs=;
        b=Yonfa6r2aTAA7K2Q3rzZ31HLSWfK+rUQeeWpm5Y+rsanQPK5pVWu78frOs/uaV7M1d
         0O9Sgmz/0HR5j7o0Dm+3vbiMldwpiOVHfRtF9W7NKKT2JPCKK6XJ6lgmKDuQ57mVNx0P
         ZL+BCVsNYZHT0Z7ruIl27v7c5wGEZiDnrTo1nGP0THLUH9sROLxgAr1ZwMXTt+TutR2g
         cF2o+NFblT7TutVJnLzY60BV7J+51pm3zH3B0h0kEpDXEBdyG+d6t4w+qv8Z8wcygVAX
         tjnLt0X/9TopjsP+gYdPGRbgyYri6+nSafDkWbsr8jUkspLwPalUsUYevUqvFdjtfFV8
         AaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733801508; x=1734406308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv0YJOP4wsTr0yQs0O9EirzGuPC4EYUuQmTwZ8ZwYDs=;
        b=aCWNtUqPOo4Ng1QTR8nCsjWKQVjR8V1zxPe1A19fYIpFQy9mJ5c4DHBGjT0mrlp0Hb
         hJZHkbqyHsJN50nslreIOsKm6mbxjFCxsHA1AJrpfZ5pkmJu5xw3ZK5vpae7EH/aAvhE
         fKY0Uq+0x2Bpq2x/wgEA09VhR1Sk/NO9a/MFOGC1ynOpXrzxR3eiSNqAdPP7IDdjOwGB
         IzVR4/71Erhc8N/USgWXSPlR72BW9MhoLgg/EPI+UNfn3EKgOGpL0JS7qZ0vzRjRDOKA
         NfIU39X8XjidXLiyZVSXWAKvJylBaY4cjwJU0ZlTWdkh8Fnd89bYqV8wZs2jsXFfNyT5
         n0eA==
X-Forwarded-Encrypted: i=1; AJvYcCVUGYWp0fZnvN90zlDLtdpmTKKOcDDEgZy04LYGDXeFQVWg+LlRbg65Zop+fXdCs7ON5QZhUuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYiJ4Z7MTi7rrxD01IUXjrk2GNO48ea3h1hJ7cI27VdqceXNZb
	b9m/hBQ6NgMk52ybHVZuHkrL/9T9bmHq49syVZs5ZfYrPcpigr71gFJVjSshug==
X-Gm-Gg: ASbGncumzAp5Fb1hvHA03wnwC7KvIzIWVSbDMzgOWHtcAQ3Yyp068SLpVNJ8fo3Olk2
	BalEfeMPQcOWd2FBNZMcTgfKsjl5usvnEYKbCTAiVnRBNrOAJ9rQVHRiqLCth4oK/2HN10yfXqA
	jcaH1GEip2qrYOZmVdu0A+pNba4zjYCIRZuubMWJ2JyckP3WHoyesfXZMLN+sBy1pBhzScupD9D
	H2F1SE0LsVXmD7QgdCDK25zOzQxXDiiMSSi1HMFsbxPp1hVHUKGmYYS/z9oDjShpIEi0I5jV18X
	X8Oug5B4DUjsVmfq
X-Google-Smtp-Source: AGHT+IH+pvo4/VQN7viU5wtrvbWZV7k0OuEnVi1lVzkq1rjMfGLod9qaEdLeCxJfDRPWaSCkHHj1EQ==
X-Received: by 2002:a17:903:2391:b0:215:44af:313b with SMTP id d9443c01a7336-216718a490bmr1533575ad.0.1733801506645;
        Mon, 09 Dec 2024 19:31:46 -0800 (PST)
Received: from google.com (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9ef1sm79715295ad.159.2024.12.09.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 19:31:46 -0800 (PST)
Date: Tue, 10 Dec 2024 03:31:42 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH net-next v9 1/1] binder: report txn errors via generic
 netlink
Message-ID: <Z1e2Hn1ChSXCprwo@google.com>
References: <20241209192247.3371436-1-dualli@chromium.org>
 <20241209192247.3371436-2-dualli@chromium.org>
 <Z1eO-Nu0aowZnv6t@google.com>
 <CANBPYPgU9uL9jdxqsri=NwLTJcFpzdB313QsYjSQAuopRppTDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANBPYPgU9uL9jdxqsri=NwLTJcFpzdB313QsYjSQAuopRppTDw@mail.gmail.com>

On Mon, Dec 09, 2024 at 05:26:14PM -0800, Li Li wrote:
> On Mon, Dec 9, 2024 at 4:44 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > +
> > > +Usage example (user space pseudo code):
> > > +
> > > +::
> > > +
> > > +    // open netlink socket
> > > +    int fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
> > > +
> > > +    // bind netlink socket
> > > +    bind(fd, struct socketaddr);
> > > +
> > > +    // get the family id of the binder genl
> > > +    send(fd, CTRL_CMD_GETFAMILY, CTRL_ATTR_FAMILY_NAME,
> > > +            BINDER_GENL_FAMILY_NAME);
> >
> > ok, what is happening here? this is not a regular send(). Is this
> > somehow an overloaded send()? If so, I had a really hard time trying to
> > figuring that out so might be best to rename this.
> >
> 
> This pseudo code means a few attributes are sent by a single send().

Ok, sorry this broke my brain trying to make sense of the arguments to
send(). You imply that the nlmsghdr, genlmsghdr and so on need to be
populated accordingly with these arguments.

