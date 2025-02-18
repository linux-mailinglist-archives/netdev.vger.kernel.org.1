Return-Path: <netdev+bounces-167522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93581A3AAA1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB64168BCF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2291BE23F;
	Tue, 18 Feb 2025 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4hUXw18"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21833286280;
	Tue, 18 Feb 2025 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913463; cv=none; b=DUuOH4e+wuhVa1rxxRwX9DAllt1eCNDlpWpPQp54y3LI4vw2ba+C7Z5kugPf+WUhTXMVJ/87lrth86CjRSbCG5kmHuirDBskl2vzgCtCLT70uOCTQvt7AQ2Y2hfkUZukVLSHY0mDrMHLioXihQ/pklWEXTY2+zViQieu67+KxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913463; c=relaxed/simple;
	bh=zIhBcr24QrlJV5vSHWIFsWcq/BbGAUz3t/Cp90kL/KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcvTKoTXYE+TxOUkVXQz1awG6/ol3G6mmEXHZk08B43xnSkYIOve/1QcPt8OxjP0b/6kKcrRlU3Lj5l+Wm6rAg7oXxT7VUy4EcheKKZvXgXXiSe98AbeqSP5IxJEnKTcSn1xdEb8Sz9Il+mMoc3dsXK/YwxLIoFyZ6NUQMbkdnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4hUXw18; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22128b7d587so49871945ad.3;
        Tue, 18 Feb 2025 13:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739913461; x=1740518261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2/gk7oAOnU9fWd/TFGkNr0DWmSFXVkHFebKUPmAYkIU=;
        b=A4hUXw184KKPOtdVk+GzoBf8j259LGnOgvigIHJ12x8imbkmd6tCgVGOQGRUVvliT1
         vDBmBqaCnHI6MKmoZBuDnoH6/gn3vYBfnyaj81+/IpjHSvPEegOzouTD5G8gF6UdGD+h
         mzIiWWC8UpXPSolPYYtQLyD/eKw8Ypl+d42UzwGJGNYGSfxDeQumfynBFM2O7vvBYTUz
         T/wB/8WGXlEAXAEdaEPKNp/LrpfWzqVuZpK0r1aIS7Je+BD0vJ0Sn7fsY8WAC4rEQdfP
         JHv74yK4NjOmUnc/4V6hmRKVI0k13tHpBcjI24+PkcP1edagULUGcUaCm8lyyWaOmowV
         +SSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913461; x=1740518261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/gk7oAOnU9fWd/TFGkNr0DWmSFXVkHFebKUPmAYkIU=;
        b=J4eapVZGnOzP4MzlfpItRxa25GGKsDLMDVvzCVcRuQbPFHifoHZ6JIFzQAoxF+GCIp
         YSaJxJFzuhhoROTCfzX2f0qfKH2HrFnjHlZDsAfMsLFb/tYtaShKxGH9zJ2Gq+GgF/rS
         QoCyq9nBQ/V9ob8mz68jqM5bnc2whK8jOHwKLqt+KbleExxJ0Q9miA4txSpcJ66AbHji
         a9r7Mu2tMMuPn2vSD8I1v9JDf+HIwasDwLw9n9t3Rx0N7EE2cV45iY6qPXK/toe6/vCs
         OXOJsqH0+DbGFfIoNKpVoctuCY2y3s3QYeiogLmJJTvjF7IhBD3D6oWHBcqiLB3NeBMs
         Qz1A==
X-Forwarded-Encrypted: i=1; AJvYcCVls3IWyc0N/U6QWgfgIQdDM7fDTYBBCIa5qtu7kHUz3ljICxG4JD84WPAtoLssxrmQI+XpB166YJ+50no=@vger.kernel.org, AJvYcCVuN4a+eoXKI3B4BdWF1B+cyoev0C+z5IW+Xvnt62+LON5HI8ZMrsngpc9VBw0uJqAMupoMoFwV@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdWIbkNCL3z5W3yFz91S5Pt4hz4RDseUE4UvJylPCaU5NYewi
	wGkQ8RpZ8zFuY5aFmX7REWknJnStO8PF3wzaPL2O0EGTMC3qaCE=
X-Gm-Gg: ASbGncsVs6ApEOw437MDNTs1VEpzwWritEyg8LLn/s+RECYcnXupVjFW0n61QrzOoRQ
	zmCMUG9rqywSIMjXbj0rcaJcvbLXmghfcYb/9vcPxqzg8Sxzi0S4GsYyGuimT+sPECHSV63M6ov
	VefRqut7COLt1LqXopr4QNRZJSq8H6cxOXzo1ke0IpLCVVNON8Nc3AuGMSu8X6b0zpn5khJjY6V
	6CstZAHH6/oCFQwmf43I/Bp5QS/AIXtxvBx0hH89ixSUW7L+dQ2J0EmfPD6nHycWExQ50KbmB24
	VUnllP2uyjDMsEw=
X-Google-Smtp-Source: AGHT+IHo/2S84pM+IZsmeby5LAyYGggucs82TzObRa8T2oKSxpSsz8hZBB1d/1AVPPRG0RsOTHWVBw==
X-Received: by 2002:a05:6a20:7486:b0:1ee:c463:23cf with SMTP id adf61e73a8af0-1eed4e83ba3mr1071753637.13.1739913459746;
        Tue, 18 Feb 2025 13:17:39 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73265678abasm6827031b3a.27.2025.02.18.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:17:39 -0800 (PST)
Date: Tue, 18 Feb 2025 13:17:38 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	ncardwell@google.com, kuniyu@amazon.com, dsahern@kernel.org,
	horms@kernel.org, willemb@google.com, kaiyuanz@google.com
Subject: Re: [PATCH net] tcp: devmem: properly export MSG_CTRUNC to userspace
Message-ID: <Z7T48iNrBvnc8TZq@mini-arch>
References: <20250218194056.380647-1-sdf@fomichev.me>
 <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP7fGd+6jvT7q1dRxfmRGbVSQwhwW=pFMpc21YtGqQm4A@mail.gmail.com>

On 02/18, Mina Almasry wrote:
> On Tue, Feb 18, 2025 at 11:40 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Currently, we report -ETOOSMALL (err) only on the first iteration
> > (!sent). When we get put_cmsg error after a bunch of successful
> > put_cmsg calls, we don't signal the error at all. This might be
> > confusing on the userspace side which will see truncated CMSGs
> > but no MSG_CTRUNC signal.
> >
> > Consider the following case:
> > - sizeof(struct cmsghdr) = 16
> > - sizeof(struct dmabuf_cmsg) = 24
> > - total cmsg size (CMSG_LEN) = 40 (16+24)
> >
> > When calling recvmsg with msg_controllen=60, the userspace
> > will receive two(!) dmabuf_cmsg(s), the first one will
> 
> The intended API in this scenario is that the user will receive *one*
> dmabuf_cmgs. The kernel will consider that data in that frag to be
> delivered to userspace, and subsequent recvmsg() calls will not
> re-deliver that data. The next recvmsg() call will deliver the data
> that we failed to put_cmsg() in the current call.
> 
> If you receive two dmabuf_cmsgs in this scenario, that is indeed a
> bug. Exposing CMSG_CTRUNC could be a good fix. It may indicate to the
> user "ignore the last cmsg we put, because it got truncated, and
> you'll receive the full cmsg on the next recvmsg call". We do need to
> update the docs for this I think.
> 
> However, I think a much much better fix is to modify put_cmsg() so
> that we only get one dmabuf_cmsgs in this scenario, if possible. We
> could add a strict flag to put_cmsg(). If (strict == true &&
> msg->controlllen < cmlen), we return an error instead of putting a
> truncated cmsg, so that the user only sees one dmabuf_cmsg in this
> scenario.
> 
> Is this doable?

Instead of modifying put_cmsg(), I can have an extra check before
calling it to make sure the full entry fits. Something like:

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2498,6 +2498,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				offset += copy;
 				remaining_len -= copy;
 
+				if (msg.msg_controllen < CMSG_LEN(sizeof(dmabuf_cmsg))) {
+					err = -ETOOSMALL;
+					goto out;
+				}
+
 				err = put_cmsg(msg, SOL_SOCKET,
 					       SO_DEVMEM_DMABUF,
 					       sizeof(dmabuf_cmsg),

WDYT? I'll still probably remove '~MSG_CTRUNC' parts as well to avoid
confusion.

