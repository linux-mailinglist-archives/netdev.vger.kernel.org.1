Return-Path: <netdev+bounces-277370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F7QJqPk2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:53:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332B03D6674
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3FB83028C6C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1283BC67C;
	Fri, 10 Apr 2026 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHfSK9u4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328EE3A16BA
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821983; cv=pass; b=gCJo9o0cTbdUsTuB1nPwF7bB/UjREBFdnluNR3Fmop76LyBsXZ0h23WUXmwz6Teb5ZTuoZJ0pukRMX6+FOphjvuhQ5AGcB9q/huzsYVB2IEzs/K4sk+pAxgvDsY9qX8W43bG9kUzDUUGF3/W6sVAUGYCQNPXzp3VSivrD4rhf3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821983; c=relaxed/simple;
	bh=mlGDrQZHx7437BVttcl1y1QWLt/oYUTtKAGxWau1JKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvoMRwH5sHRvFUmUBJEEj9c0l0NWF5xjVXOi0ITB+zz6H9aJgpVH+v/jqTGdSXMSkA7pcjyoNh5HrsTM5jMEjB0uNFEQTq/DHuhCJmvsSMyaiXvy5kd2F7pY4HEzsS/DVDuEVt+cq80YPvAA2EnACRzXWUadJPPBYtO2F0NL/74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHfSK9u4; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so19062656d6.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 04:53:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775821981; cv=none;
        d=google.com; s=arc-20240605;
        b=dXScSqHWzvCpAUnMoGhqNd4ezElDgzgn7SmUfJHFc8eceNPaCmQSdjhnAMPzgbZH5a
         Xk5RRsl8JX7Uyfdl4gn+zNx1p8pgqKsTJI8PfcwlhYIE/iIgXPAOSUqG7UsBWgQTr80N
         iItm+2yHZr75ajQ+UHucmg3k6n8cOLaPdFl2u3UOzvuuJmskSCw5lwLz8jfUHUIrGXKd
         Igj6HxISB3Ds9GIKh/ZshnPShOMCkeAtNhSBZk6SZtSp1WzvWclnNtYY9PZZfczC8EBQ
         ODwkKlu1hSVZMzzfvI+UzD7rs8ejt9Xktmi6WnlnXGBlRs11DnOUcM4s1qaD50htDe4g
         cd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mlGDrQZHx7437BVttcl1y1QWLt/oYUTtKAGxWau1JKo=;
        fh=FatiU2n/9OsWVhD31mxpVlvA8ypXa60pv7ywfGmQERs=;
        b=UlwDfIxu+9ZiVrzMiUFKoBxRxbJ871OmYBBNRNOEk73kNI02LgN8qzKePnEzTSSxF1
         DKPXVNhMRegyEwTPdlGV+N+bIbOyHtClPFCHof2cxARjqODBcH3khUAfOGs1XSpnmAV9
         Tg3tIigP7AF3T/SEDApmMZYxevelgrufxz3R5YOlbnnh1b/oQKAuT5Ys0G+LvYxWcyh2
         dg3yA7ydmXL53EmyXsWPsXaMTJog+v+8LzyK1iysItIEiOSci8eC8ClRmqpuREvEiCDJ
         5Tk8XdIKn9dP4wVgDPhyJSvsC+rL9w4BydL7Gts1KIKDuHPJuMm87Qpt5IGVqjqWwAqU
         ZHsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775821981; x=1776426781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlGDrQZHx7437BVttcl1y1QWLt/oYUTtKAGxWau1JKo=;
        b=JHfSK9u4ivXqvkRlJFMTMtEvE5K72PcTabMRIgVcU+TUods8wT3enxV23Yq7ghKrne
         SH83L0XiLM2+SXnLyyHK2/xp0FD2OUtU9Ik+Xi2stj5AoCByeUrQtNc42O5SmWOtIxOA
         WxSaJzDMRTrhiJ1ul/l8rK1suHN/CgrmS9qFI1gi1R9qVndy1wS4HgxGWV4f0rtxBNyo
         2T1sDa3JdikxuS9AVTS3TkG3FlpzkyzIaEeT/LkBvDHgaTowcy3GoRvH5oSOuqxSRkwx
         BFTDHdXsbGZcjJ4OX9IvA4KavxT545DhhhM+smc6Wve0cU1TXx5E9mXJyRBTPBXhm28/
         ea9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775821981; x=1776426781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mlGDrQZHx7437BVttcl1y1QWLt/oYUTtKAGxWau1JKo=;
        b=NVDsKGwm/zU6m1/UjynBOIpgZdMnIyyH6jq+pQ7f4OK12QhOWVyE3M8KQn5UuhdS5g
         Sc/E59v9u7AoGCPLFwWsHaCmNomRQxYI7jXVtW+A7k0OlAKSsVOiaVp2/gfNEba/cqU9
         xzNWogjTxeCjwA1RhTRXu9yAKPpwRimeJvX+dkuDGooViM/plQFbqYWoBwSLjF6EXGAo
         CjxW88NBcmAlkf3lfGz9H5AD1cYwy9a5wbTR3yPue/TSCUBvjbw6Bm9ZMxKHoX4idora
         AuCq2LP1v+AsBRxAIebTNmDCkOgbOIp0/5EmFDe9mAuqwqk+bmI2tvj9lufthZpQP2NU
         PBQA==
X-Forwarded-Encrypted: i=1; AJvYcCXUneDxThHlUCCHI5yFK9qKUPv8G5Q5oF0umzS35pJEqDT1VcDio+O7pmuLk0nnMIyae0s54vI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VYhMX3jGcB1R4ZlkHCxo9Fxy1ob5bUmL0FEPeXRCiyIuHM6/
	2OCHh0PLakV59e5JCgArdjCyzFrZoJLX/fxOdJ/qVcNlM5pS1+gc2gZ59hbUdWbAVto/4LkxNvK
	dcQeXypDcUlot7aoIIPp+AnIMGQlXiz5lkryUobel
X-Gm-Gg: AeBDietVT5yfKfXe0t7DDujn3dd4OBzJX8IsXYU6xnqcl1qyl+CEPEg4Oag9AZFi2QT
	O7/8lDXReCeWgHr7lnPJr4blEmiZKxtCyFz5w3H+17RKAj0C3JstmsREWzEI2E9FQHMAiUAhN2p
	r3GeqKcs+fiyQv6AvqnvipkgBnukunePXEcoUy9XP6DKO7pxADpNIj2iL1EUS9BU6HaKV2tt9E9
	NKU2hzTXCWe1HhUlICQcxDavH8bBfHGdQYYyqv1t4Vw/Kg7WhnflPWekga05zI9IGr6WtdxYUGF
	I7uqTtu+/RbFEC2c5pHGypeqH2uwyjgJZ69r1P3gF/Cx2gVgOYLFqixcwuHCTN4lKIZIkX+Ukcg
	=
X-Received: by 2002:a05:6214:598a:b0:89c:87b9:a5c3 with SMTP id
 6a1803df08f44-8ac7469ee5cmr97456556d6.25.1775821980484; Fri, 10 Apr 2026
 04:53:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com> <CAM0EoMnPVcdHoy4BNH_sC9H65iu=sHWQcZ25r9_0qcfdjRaTKA@mail.gmail.com>
In-Reply-To: <CAM0EoMnPVcdHoy4BNH_sC9H65iu=sHWQcZ25r9_0qcfdjRaTKA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Apr 2026 04:52:47 -0700
X-Gm-Features: AQROBzBGf_JeW0ivQROZPFWHxZfQ1PK7B1sTlsDIH_DsEHJpuIaWDz-U3fgynKc
Message-ID: <CANn89i+RJU25zAdjQMR2xWZcoY-xL55NBaBL-KzcQ4cx=xOpWA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] net/sched: prepare RTNL removal from
 qdisc dumps
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-277370-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 332B03D6674
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 4:49=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, Apr 9, 2026 at 5:49=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > We add annotations for data-races, so that most dump methods
> > can run in parallel with data path.
> >
> > Then change mq and mqprio to no longer acquire each children
> > qdisc spinlock.
> >
> > Next round of patches will wait for linux-7.2.
>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> with a small caveat: Shouldnt patch #6 onwards go to net?

We are late in the cycle, I will handle stable backports later.

sashiko.dev spotted some issues, I will send a v3 soon addressing them.

https://sashiko.dev/#/patchset/20260409214914.3072827-1-edumazet%40google.c=
om

Thanks!

pw-bot: cr

