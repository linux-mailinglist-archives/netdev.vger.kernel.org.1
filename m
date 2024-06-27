Return-Path: <netdev+bounces-107099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F1D919C17
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F7C1F21E30
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3AEA50;
	Thu, 27 Jun 2024 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MSa2eXcv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899B4689
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449496; cv=none; b=E5Ug4H4ukUiDzx+832akDNwPG7Gr7Z0lF4JyIuIrrETwH0khMhOjq6ggK8CqtWDlOF1f8dzZHb1q66DKub/6ZpLKDEazc8sEE37wN+EY41VaDcKuU80Aq+05P6kBUMX7gn+7Fu/v907wNDGN6Cy58pY0Cf74kUO5qL4QzpcXbPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449496; c=relaxed/simple;
	bh=F8EoZ0KgtTlDrx+RHUhANavpveeXSZDay8RJ9TkoSWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQYFiXTSxkoAh17apr85UKIIEAdgFX/y5BYJk63ahXibX9SazDbL1geu+g3+xdhesUwer79cr0Fz7ajYnRUb3SL0Bu/58oAcORNoG3m8TzcUeYhllbBRmM1xRx16/HXVFsQa1/8cWlorvNXfUaqS3SwIkljYNj1Y+4xWey7mxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MSa2eXcv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cd717ec07so6759793e87.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719449492; x=1720054292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvw1jFo9mXXB8AmAp5CxanBbcNFEjyqwIr5wHdhTfGg=;
        b=MSa2eXcv1hB5GQA/g64b2im0/6Ej57cv4Ks4cZ95/3T+D562DSj5mLOJeK00E3Hqrp
         cBZ+hBd/nuSiv+t3aL0m0zmKJzH+nZ4nwc/XgZjuC9fPRsgXP9xe7WY6r/U3vyHtt5KU
         fWFjBFqikC95fa8m95R0ElkYSPUGArjyb32hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719449492; x=1720054292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dvw1jFo9mXXB8AmAp5CxanBbcNFEjyqwIr5wHdhTfGg=;
        b=dBH2KlekljOO+JPcbjH2/Gm1Rd3bmmZwpHa9MYSQLnYfp9ZYcchkPiHXEZCAgaXdq+
         l79UmQIbNykV9p5UhI1h7p23W4QN0Y8rVRI7Hc6+QIY9YZ4q8DEwehgqDq4WmCyIbAHm
         URRAqOLdGNQBkwqhcMPLPTYOzHfpipx18n9fxH3VGMA2IvWfxpXz/yBLwPLDZMb2czOs
         Sp9F8H+pGGK7A1fxiav4XnbYDKJBxLUqLyNSaolRW4nJ5pKoZfCoAREJWaKZNsDRpp1x
         eUrU4emIKLbDKZMr3KpG1vWPxZ+pZbbYtCAvYYiedB85Gi5UOWl/U2zCtu/B8H6ajvey
         kjog==
X-Forwarded-Encrypted: i=1; AJvYcCWYe1rL6tm7fBf1ofbvJPuhcE7VJaWPBr/29/k1iv/aY/uZcrY0AOYjzcaT8B/eeC8Z7z7SBGoiI2iX0JWzCMHH7+4XTF9e
X-Gm-Message-State: AOJu0YxsC7kqaL+hIRYGgAEhKUfvdmyvD9ekkeGt0fbnf4TiWfgMxSvX
	T3vza7In5iRYQHqoLQCS6kPbw1Ku2v1MfXDFuaLUOSodC0hLYVFJ36ZPgKe6xsRkYa44pZzenER
	Jvmokvw==
X-Google-Smtp-Source: AGHT+IGshOB388FhgwZeA5qMeSAH5jZh6B4XPYOgclPhmAdBcZdRPZnmaT/GGPlv5qLq5KilJ/xM6A==
X-Received: by 2002:a05:6512:2805:b0:52c:dc69:28f3 with SMTP id 2adb3069b0e04-52ce185cfdfmr9341417e87.52.1719449492065;
        Wed, 26 Jun 2024 17:51:32 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7132218esm20283e87.276.2024.06.26.17.51.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 17:51:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cd87277d8so5850758e87.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 17:51:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfgyDqovOvIcbvDP84DvniG1S+YCbdETxMUbBPkwUqYIWFy7eIG3KQcKROn2b6F4CfedGmBFYSIGsl53cP7HcQyBvk6gWk
X-Received: by 2002:a05:6512:78f:b0:52c:d5c7:d998 with SMTP id
 2adb3069b0e04-52ce183b2a0mr6378530e87.35.1719449490723; Wed, 26 Jun 2024
 17:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626233845.151197-1-pablo@netfilter.org> <20240626233845.151197-3-pablo@netfilter.org>
In-Reply-To: <20240626233845.151197-3-pablo@netfilter.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 26 Jun 2024 17:51:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibyec=ObQrd3pR+cUUchDGXFk3bTp435jOz+NP0xEzXw@mail.gmail.com>
Message-ID: <CAHk-=wibyec=ObQrd3pR+cUUchDGXFk3bTp435jOz+NP0xEzXw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] netfilter: nf_tables: fully validate
 NFT_DATA_VALUE on store to data registers
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 16:38, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> Reported-by: Linus Torvalds <torvalds@linuxfoundation.org>

Oh, I was only the messenger boy, not the actual reporter.

I think reporting credit should probably go to HexRabbit Chen
<hexrabbit@devco.re>

           Linus

