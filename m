Return-Path: <netdev+bounces-249142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22142D14C32
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 206FC300BA32
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4743806AA;
	Mon, 12 Jan 2026 18:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="djW15XS3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154D8350A02
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242423; cv=none; b=b2O7zLCzI4v1eiCqKFRz8JbTsJt7MJwmmLZ7WDS2dvFVFm2lDJEGf7WL5an18KBRbcvfHHpsC6B23qsQeYzkWzPh5o67EP0vNfm5Tb42snhGzST3zSXzZLhICNBT2+vXRzsHTLQdFZ+gXUeign1NJVsi9wDQ9tVWQjL+VRvjLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242423; c=relaxed/simple;
	bh=i0zEarnDJxStf2hsXuiCgG16S2FlIpCA4KHhqzHgYIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LR8hUSyKlfAzMwnuM77K3EExKFklFtv5L43o1DvTLLgGJECjyUlINF0fHRxP05fV+yBfyYdrfJ1SXqar71ULQiBp5i0uMTvE6x+B+e7q6/Fo+5yoTdXDG1bz/Cjj/MXwIyNRtl6XWoylnk9xIMFeu86LQx9ynjJXg9AnbpmtMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=djW15XS3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98983bae80so2903039a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768242421; x=1768847221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYdFJX3B5VPQIPZyrLS+sL1dIozE68tdUnSE+N/pLbw=;
        b=djW15XS3bd4a0FFvpurKmSEw+lrV3eDPCgEeYvT1teSN+/jMBOyeCncVCsEe7/Ogm0
         ijZcDprPnA0SpK0e84A9f/6xIy6MJGRvk0bmIFpM9mMkkif4AKUt+Ke7uXlDje2mODWx
         zqXPk/ZXvi8jkCc/wtTfPetuZIaN/+/vryM4Xx1CrH5N50RD8GAVBd6bzBGCcXthrfP1
         bY8UaKMn2qOpoLXLSquKrEjOxPve8edUiv93SU0BN285+4P3uihN5bqmgymhzNLhvlFK
         fCUXv/fa7yuhtpWmeMwgj2JvozprunCx42ZD5Q3MdGeOISDhCunt64hxm/9egsvpmt/C
         OoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242421; x=1768847221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYdFJX3B5VPQIPZyrLS+sL1dIozE68tdUnSE+N/pLbw=;
        b=t3VLI/HMKpKEp33j8pTYniHQFi4u7iTjP96GRHBwCYg2Un8qB61WGONLcd776mJ6Ug
         hw10LVXGE0fXlNaH90p6ewO2KV/Zfgzzfl2xYU6FImwB8AqQQg/GeIwdYYOjceBDcqnQ
         MbJH4M3T9Qwo1fLP5HIodGVkqKX0QIxhWHMN+c4ZQ7nBhIAeV+zy30dWoyx8atYIVWoV
         d11JDBm9g52G7w0xiQSfcGYfvEvQsp9S+IkR9snGUWhJ+/7UquoV4Z5wGVLxJmizU/8O
         ev6OwcgXizcUVZ5NjIxtD0/cPKPjadwP3EH2prYXEqhbilI7wtb1REHvWNRBaQxsAlXk
         90cA==
X-Forwarded-Encrypted: i=1; AJvYcCU7fkAwb1CWccMyAsGUnQ2hvsEhOCMjKUIXY3QybI2l2zi/RPrumSKV5yEw9qnUqF0bmh9JmMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRPgFsGZ5aXmTf42aT0U2HgAaLcoeuzKI0xaPalln2//1mVbl
	V7omd0mtV9altwVcKX8tyuHY9yqZMD405Rg2Zhn0JYys2i94UXdnOBmn0uYiL2AW0/V1bD46Vg9
	n3FQRV6UdTQ2DBeLLNHQ+weNiOKZ3rPJVFXCg2yNncMBQ5rdcxyU=
X-Gm-Gg: AY/fxX5ufDfy7guc7PtvVQM5K2RH288N+gVSgt7OXcj6UJIXnE1n7v82yZ/x8wO4gz8
	9c5O7BsJ8mnrgONMDrOVM3dAgWgYAj9y8nSN0I/c7/R2qrBRK0exaQpjnLxGB5FxPMaWy2crZD+
	Iq/AX0P0OMRlZUdEkCsh2kHDhbP3Q7qE9Dt5pAntUN+mx3uQF5GdDGZYetzEHuvMc6peOVoISf4
	mmcRQxRUu4/8H9oY8+VZAzzxR128WhYBwen6CCOaIchPPRjCl8qpZrYRBuK9YHbEXzi330rav7Z
	fASS7xf3+ZxvJg==
X-Google-Smtp-Source: AGHT+IH9C9eycQfFrt77JsquDX+8N2BWicz7lOPFuH0Mu5x1bxxmBMzZvd5zIbyWFP9jddqBdnaBrwS+huKtsrKRtAo=
X-Received: by 2002:a17:90b:3d47:b0:343:e2ba:e8be with SMTP id
 98e67ed59e1d1-34f68b65f4bmr16099921a91.10.1768242421412; Mon, 12 Jan 2026
 10:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112175656.17605-1-edumazet@google.com>
In-Reply-To: <20260112175656.17605-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Jan 2026 13:26:50 -0500
X-Gm-Features: AZwV_QiBFx1h8i4ysqGL3aJNEvy9jrQCU5lPfcu44lmaDO4PUcP3CLpnQQv005E
Message-ID: <CAM0EoMkg5W0hGyZo7TMxj61mGDtdZDcTWjJQ1ZMx9oAxM4+=_g@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_qfq: do not free existing class in qfq_change_class()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 12:56=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Fixes qfq_change_class() error case.
>
> cl->qdisc and cl should only be freed if a new class and qdisc
> were allocated, or we risk various UAF.
>
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR c=
ost")
> Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6965351d.050a0220.eaf7.00c5.GAE@go=
ogle.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Eric,
The patch looks correct.  Initially i was scratching my head trying to
see how you knew it was the same issue. I gues on a UAF even without a
repro syzbot can tell you exactly where the UAF happened?

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

>  net/sched/sch_qfq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index f4013b547438ffe1bdc8ba519971a1681df4700b..9d59090bbe934ad56ab08a597=
08aab375aa77cf0 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -529,8 +529,10 @@ static int qfq_change_class(struct Qdisc *sch, u32 c=
lassid, u32 parentid,
>         return 0;
>
>  destroy_class:
> -       qdisc_put(cl->qdisc);
> -       kfree(cl);
> +       if (!existing) {
> +               qdisc_put(cl->qdisc);
> +               kfree(cl);
> +       }
>         return err;
>  }
>
> --
> 2.52.0.457.g6b5491de43-goog
>

