Return-Path: <netdev+bounces-186181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C33A9D629
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819013A837A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AF2957B7;
	Fri, 25 Apr 2025 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wz3AvF/b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CB1B87F0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623234; cv=none; b=RkTy5eEkEfM4pufa/ENGTyNxs2qqB9b8aU4lDQNoa/rvXlSmfgZzSPAdA5bx7S79Gd04l2bFukOtkv/He96vw0cMMssOidRiMcZnWBZXs8TtvfteFN5QBsyGgT/EEggGItjX0AOF4etCS9PkP2b/M5pefJXdjhnMCWMZiR6Twx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623234; c=relaxed/simple;
	bh=iVDgmbjAnvB3AqJz1JtnA+4x1Fh0/lGPQT3GV/3GH/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpmDbZf7w+xBJL/qkU8HwESGTAVilyUMtVid81ahaqbHM+1QI5MA6xqaqFIQ1SY/6VP0hMfEi9wjEpEmKsTq0NmXBXXn2lNE58h7n3RnXu/K2U+HZv6Fi4w+klVUFPPHOnfloWlx4p5/GwNK3gGKN6ZQFjOwm5+lkY10nsclMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wz3AvF/b; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223fb0f619dso32543755ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745623232; x=1746228032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5jquDGFiiiZhpTAIdmfIoy2mJCi05q4uBNwr7LqWx/E=;
        b=wz3AvF/bPoP1HYQuFtNZl5JfLB3n3yQefm/DVP7HV8RMW59GWlls+hFA+OoDNqvfVl
         Kp40b178+3/V7eeKcMgFtDfA9+wTGUZg2fDCGdpiqYM0W8esEntqufhfFDGI89R0Gknu
         U6rf95KwH5xEzRCElwxTNd5RsYX5hHdY0BYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745623232; x=1746228032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jquDGFiiiZhpTAIdmfIoy2mJCi05q4uBNwr7LqWx/E=;
        b=kEN2AvyyVoQSwBS71y3OdVA97hRLcjotLkCFIiXEep5D+JMizTHKFRfAO7gme/8rZk
         dB9VpyBG2h/YXZr0c8a69IPHFxJp9GahDx4VZ7cGk/+3hg62Mh5che9pCeCxXPew3JZt
         zrTZ2Ll/tPn+19qz4+SSRd+sOCE2cSsXQRyt986iFOqdB7gcXcSvSdoqH3Um0DmkPous
         S7G13hiwVsqHtm4PPxZScRBLCW8qiWSsgoT66zznYACNcbirrHeWKU4oqacQ4rpP/bvX
         2Fy6F1ynPZ5C8tlJVD9DbRyPfvjw+/3FtZux805WAzOlLwwYh/+luXd74yKN/HarcIhC
         elyA==
X-Forwarded-Encrypted: i=1; AJvYcCXu+uvt5Df4OWXMRAhAoZQn2VP11oC5A4f87WUPA2s2pCsdc43jg6G+e0H1wfnzBESPGFlit+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoD6nuef9xx48jF5nmjqxhtO9og7IIhukxw+lFOy2G0+OBHvne
	nV23UoeEmtJvqUiYcX735CIrtLBi/J6z1A826oaU0xA5krlW2jsZNtEUI979IH4=
X-Gm-Gg: ASbGnctaHpWX5LxS4JartLw1YaSDumGfgnPT0CzgljjQ6M/iCzLpIuarWCHCRltOp4R
	C57Mfk6tT4CVtMy5WhKCe4KT6bjrzelw6vn4s6BUyxoiV80SmgEecbg/CeHkst66MuqsBqcPOz5
	JJ93jla+qhizYVRmhzWqwm9Fy85gN6ljTl8vYXuIaYW5TfcHwASAZbf4C6pE0pJYtRP2HtjOhS3
	A/p1xUuFYzsIt/bRPwXPM9oD/fWVONR+p6L3Vi3CpgVsBaSxNcQ8DWfiR5SEIu+22FeLn4JVUoX
	02sFZ9Au4Skgy3NrMb2ypM2A2BuHQAXCJQGgga6dYYYEwT/eLhPtegzSwXkMrznK0/HXcckF2en
	44nfH9u8gGkOg7WrrpV7mp/g=
X-Google-Smtp-Source: AGHT+IGUDCW+xjlqEVRCrJ7oP+WM6CTLKVce7156Oljwp7AI1/8uUgPJKtLDGJbYV/VLofrqi6iumQ==
X-Received: by 2002:a17:903:410c:b0:224:1c41:a4cd with SMTP id d9443c01a7336-22dbf5d9f29mr46361775ad.3.1745623232228;
        Fri, 25 Apr 2025 16:20:32 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76db1sm38487585ad.13.2025.04.25.16.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 16:20:31 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:20:28 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, dw@davidwei.uk, asml.silence@gmail.com,
	ap420073@gmail.com, dtatulea@nvidia.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 01/22] docs: ethtool: document that rx_buf_len
 must control payload lengths
Message-ID: <aAwYvE_H68kZ4L85@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mina Almasry <almasrymina@google.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
	sdf@fomichev.me, dw@davidwei.uk, asml.silence@gmail.com,
	ap420073@gmail.com, dtatulea@nvidia.com, michael.chan@broadcom.com
References: <20250421222827.283737-1-kuba@kernel.org>
 <20250421222827.283737-2-kuba@kernel.org>
 <CAHS8izODBjzaXObT8+i195_Kev_N80hJ_cg4jbfzrAoADW17oQ@mail.gmail.com>
 <20250425155034.096b7d55@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250425155034.096b7d55@kernel.org>

On Fri, Apr 25, 2025 at 03:50:34PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Apr 2025 13:08:33 -0700 Mina Almasry wrote:
> > On Mon, Apr 21, 2025 at 3:28 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > @@ -971,6 +970,11 @@ completion queue size can be adjusted in the driver if CQE size is modified.
> > >  header / data split feature. If a received packet size is larger than this
> > >  threshold value, header and data will be split.
> > >
> > > +``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffer chunks driver
> > > +uses to receive packets. If the device uses different memory polls for headers
> > > +and payload this setting may control the size of the header buffers but must
> > > +control the size of the payload buffers.
> > 
> > FWIW I don't like the ambiguity that the setting may or may not apply
> > to header buffers. AFAIU header buffers are supposed to be in the
> > order of tens/hundreds of bytes while the payload buffers are 1-2
> > orders of magnitude larger. Why would a driver even want this setting
> > to apply for both? I would prefer this setting to apply to only
> > payload buffers.
> 
> Okay, I have no strong reason to leave the ambiguity.
> 
> Converging the thread with Joe:
> 
> >> Document the semantics of the rx_buf_len ethtool ring param.
> >> Clarify its meaning in case of HDS, where driver may have
> >> two separate buffer pools.  
> >
> > FWIW the docs added below don't explicitly mention HDS, but I
> > suppose that is implied from the multiple memory pools? Not sure if
> > it's worth elucidating that.
> 
> Maybe not sufficiently. Some NICs just have buffer pools for different
> sized packets, but than the buffer size should be implied by the size
> range?
> 
> 
> How about:
> 
>  ``ETHTOOL_A_RINGS_RX_BUF_LEN`` controls the size of the buffers driver
>  uses to receive packets. If the device uses different buffer pools for
>  headers and payload (due to HDS, HW-GRO etc.) this setting must
>  control the size of the payload buffers.

SGTM

