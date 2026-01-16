Return-Path: <netdev+bounces-250557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B38B6D32F69
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AAA830C3C6A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46096399A55;
	Fri, 16 Jan 2026 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Mv6m3C27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C23EA85
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574793; cv=pass; b=XN/jqCTl9R19WZJK3GVwDMmqcSZ2JrqeumFqqACym5nI3bfZh1u2KM+N6gi4rJPNbgoeLz949nOrfqFFWuPk/pm4qkHvkQdTZXwoABXIC0EaBXSCSv6BkhWnZ4VDiy+4o9MRfISdcPK1XE+tozJnpiUbxZGWPVOTkKn2tjKiuS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574793; c=relaxed/simple;
	bh=hPnXiN2x4Qao7KItK7QeW5x/MBavEn2YbBB2x2G76BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTCQbXekyFBfDhqPN/YN9Ha6P8r9JenjBCjb6Z1XefsgW0MxWOma3/6nTWy9DveuXSj8DQJBErSxDQoUlGXlsjRuVKy1JGAGPev+2wxx7N8Yp+cw1x9Frj7cf/RIgAFlstvIBVrdFZQAsgLOQ8m1G2jasNuXYHmpl2P+uox1t3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Mv6m3C27; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d0788adaso14177505ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 06:46:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768574791; cv=none;
        d=google.com; s=arc-20240605;
        b=aPHlXfGqqE7hF/Qg8ctJhLNEbue79t2R0umjPRdeYbpSWf+p7td5A4sZTlRiUItYUX
         vlJ+CqPlCQKL/9B62zduUpSLSBqf+LBFNqVAljcUoFFGqrtwbiR8oF8KU8NjvszFGikj
         EdClzVxw66OWHUDKKFXcQ79U8Eo41AUXwSQnKH5Q/YP/dIbcoKicvSzJMoJ2OfQ/xXKs
         7b2eQohBLfOEy2+3E99e0ZGhIGzab1ZYE4th3A/lx7i1SY+2dn0+C5ehw+1IcbUBzN6z
         CdAnlAzTOdyQTud2ABovLtfcS+RdSBJkOcoeIJhWfBvS0NZjb/0J2tmtnavIMiXPAiLn
         NAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rBn+tWN2NqfC0w8iQfi8IBMFs176BlhHwYzPGcAiUX4=;
        fh=nwuWJH9lscYdvEY7RzHkrgAtxRe5V7ElwRLd3GbvczI=;
        b=QcKVbxKU+wIE3mFl9zQbttj1Uz8RgXsAZIycuj1Vf20j3i78rn6Y3cZZIF7wNoRMeY
         fh01v6s0rzQkR+2b3SS8BhbB5oCrx4RMUiQmlFdZJGwvXo2S2elDIz3mPcF1l/FzYHML
         qLbypvTTrESRRv24Dbr4q7cw7xHGJf8PpAMFmwUot5QblaQG61Y4XrvnNNwp8eWchrjU
         Ph+NMxKir4ZjxUDQYMKrCKkJbnDxL9XxLoWnuaCLnzCwS/D5UZ5hc/lkUaLY6/3XAcNS
         1Pwd6Z/rTkPh9SJG6m2BrMKxXpKszvpEU0+IUymsmzK7Wm+g1VoyIEzlxUk0bX5h/VAu
         otGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768574791; x=1769179591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBn+tWN2NqfC0w8iQfi8IBMFs176BlhHwYzPGcAiUX4=;
        b=Mv6m3C27hu+1vp7OXmxBxTBisrbNpjh3Msic3R0moLgqlSGRmTXRpjJ6KGxShZYvVV
         dalxtaFuJHQyTZAMN4i78AAa7w5HwjLMTxE/02u7MsHrQyVLWA+LdWFQbNDprk6ljrGY
         VDA9FxCH/4jsB23T6hWR+72m99gf6bbCyG3UE0/oWyOp9/jPzWW8FOKl0PqlUNIw7IGC
         v/BiokXEaNxBJz9pfRlB2JIavgMWtHoqkZviZM7xgw+kulNnW0x6cSLph1xC8W0KFh/9
         mL08+LRh3nz1IZ8KrLY6P6QcR6lDaJ8baIT3F8BCkV1ULlPvsXCrTL3SgIWGB/cdhQU6
         /zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768574791; x=1769179591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBn+tWN2NqfC0w8iQfi8IBMFs176BlhHwYzPGcAiUX4=;
        b=K/TQ3gMcoX460iPxgaegyin1fI+/bdFzpqFxOcZ3Ptfpp1FH00VDjVIb0wIVfCus9W
         PHN/fUKQ0Gudkh9rk6ROrp0BU+5hgL/+I026u9vaprG/+jAlt1OtCafHD/Plvv6/eLDe
         uYp+wO+dtlBMB/Rs9v2JeJT6Zrsh8qfa7vxbeSfpH1a13GlNuHKCtDS+CPQqcTE1D9nf
         LUtT4/MD5P03AykbfRDxF05XqrRemuHXFf5ZDTZrD+/f1N2jELpuzYdolj8TWse7UGnL
         tbqFzvw8ev2vKL8Y/D/yszJufZ11KIev9DU/zrImRS2Hq2YoqGIquqwksVwVuGB5qKtr
         M5KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wVa7awlDm80OcfqFIHfWhCsrRaObec39LRIdZwkcnImqUNVPUVg0lYmFWavVUDr3uTHUmuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eQKaoW9lmLEtHonhPcD/xE+yJhEFedd7o/DSA0BU/kxRY8xH
	6RXurIPvp9OrKNqFJIZSNYi5a3ZKI6ISf/obpiOCfNvGncGosRaLCRKVjdiqh5D+0l8RcA9GMFJ
	TbkEGZDVimi0TuoSrgRoeBKHLoPfrEZqtL2iJifh+
X-Gm-Gg: AY/fxX5wxIfNShymgHm1elRzggz9WeimzI+KLaYuebhqGnLZp2Eph9zVB4yKdcsuAD0
	LTMY+gIrMqGFlwLJolhOK5Cff38Kp6QJZ2BH+BlKhWiJg0TsT2UMnh2hHx+ADMux1QR6Uc+zyv/
	qfU1uBGVeaJp4n+0w1lrrVVmgFxmcwMpQqnbLV87hQz+uWHD5zG+gB+OES+vBolM0OsO4md+Egv
	74u9I0d5nlFVMIzsKE5yZ5R6FBhD6DRHWXZhwLEq84LiTjcbJs0iGZJZ62ahOI/omQccuPywmrG
	LXM=
X-Received: by 2002:a17:903:1251:b0:2a0:d364:983b with SMTP id
 d9443c01a7336-2a717817c30mr28075315ad.60.1768574790908; Fri, 16 Jan 2026
 06:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114160243.913069-1-jhs@mojatatu.com> <CAM_iQpXCD4pvBy4fd82d3OGungnXvC7VeR=QG+7rJYFJzAcsZg@mail.gmail.com>
In-Reply-To: <CAM_iQpXCD4pvBy4fd82d3OGungnXvC7VeR=QG+7rJYFJzAcsZg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Jan 2026 09:46:20 -0500
X-Gm-Features: AZwV_QjseBNw2eR7WlLb-u4Y3Hx7uzTSleqEMpZbxxEbkE1BqvSeykPXwWmbdi0
Message-ID: <CAM0EoM=RJZpxqOrDi5=6EYuhbDwoYfm2s3jBeNq0=iApc6gWrw@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: teql: Enforce hierarchy placement
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	km.kim1503@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 2:16=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> On Wed, Jan 14, 2026 at 8:03=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > GangMin Kim <km.kim1503@gmail.com> managed to create a UAF on qfq by in=
serting
> > teql as a child qdisc and exploiting a qlen sync issue.
> > teql is not intended to be used as a child qdisc. Lets enforce that rul=
e in
> > patch #1. Although patch #1 fixes the issue, we prevent another potenti=
al qlen
> > exploit in qfq in patch #2 by enforcing the child's active status is no=
t
> > determined by inspecting the qlen. In patch #3 we add a tdc test case.
>
> Is teql still used by anyone? If not, maybe it is time to remove it.
>

qfq is a better candidat - because it is a  magnet for hierachical set
ups by bounty hunters. And i have emailed the author several times
with zero responses.
Teql is stable and used by from what i have personally seen small
home/business routers to aggregate multiple isp links.

cheers,
jamal


> Regards,
> Cong

