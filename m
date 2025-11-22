Return-Path: <netdev+bounces-241001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCC0C7D4C5
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A136A4E1010
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 17:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A5A25EFAE;
	Sat, 22 Nov 2025 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HkA1L65x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464F150997
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763832296; cv=none; b=YuHtguC4r/K/zHRkT7PMyf/4VU76nr9DU0NBmrC2ya2e98WuTHJKsxuwYzvT9oJD5uun8shphODpBgjRqzIjpyH87B1OQDHHRAGgZclY66Fv0no1QwLkbY792hAbJLfvme0jCuihbBZPZHUebPDt+KOiA4lKvV1QXy++KhHVkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763832296; c=relaxed/simple;
	bh=g7ULHR4fQ4gTOEtOtX2W/mP1FAR6W8EHgt9kljda59s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aApwpry/z2sEfcppv6hliQnTX54FgiFulXPvoT5DkDPDa4j1D1jZsgXYle1OBY/B0lidBa2jZuetQ9VuA5hpm0GjDoKLGKwiSZcwjsBZgDhjGsoD2kqw0Vi85va1mhJPzsUkvI4SwznII7Hfx0uk2i/Z/C0tgazzse/7/Hep+IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=HkA1L65x; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34374febdefso3274669a91.0
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1763832294; x=1764437094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mogt2vG3TzthIHV1SrUDRyVH6E6RlWh2L5W1Rtq21p4=;
        b=HkA1L65xvGCFY4glWqw4WrXK8FXgQbEWQVosVatL3XxTvSf3XmBiQIGmpzf8hiFmIW
         Cg6XGHu43bQKkK5p3krZWtTyOLnV/ro/Is+gZ7KTPhuXuB8yplWdFvP+ctPJVKAYwUXB
         OgGuzEy+rLXSgK6zLa2FwZvWSXhdBa1FPWnoyxob4Zkwg17TmKNwJ8iRAOlY6CKLhuwv
         UiA77lT0UoY2CcD9kxPhNlPcmRUgw9XIh9dC6DyT56FCG8euIkWTnVc2onoi0QpmvAim
         DNYpBOJ3Y9M1bO6rnqwze/7Vi3HrP4Pvjmc1vy9Xtx7U1QLXYgMDf6ToK9BvL6TWLgUm
         5YhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763832294; x=1764437094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mogt2vG3TzthIHV1SrUDRyVH6E6RlWh2L5W1Rtq21p4=;
        b=q+EGlYQpz+fyrN/7idr/XoHxThkNQTuKTNAOI69lVJ2rDOyoo+eQ7dtv6DzhT8uqrL
         xBdonPbohignMlUlTOUZ+nb0m2ySixqMM91Wx6HYN5ydONxHpzD4GklNvuDg9EmBZchx
         uKNtKp+g3UsLUMyA7+Fj9IajquCyfRrc7Xq6ll4gC2g6q2LfGvfluGdRfQ1XbbjTJJEX
         UUK/fYD0ncLNPBoByX8tcE0/YBJRGYl0NKQz1FTwocA+O0zGWD4EuO3EkK5NuKDyckya
         dvRV2F3O7rCIpk5MUSsD6d5fM25pMT/KCG3/2AZKvRT/G1y/7HkOwmbiQDLBtwyiWlGn
         iekg==
X-Forwarded-Encrypted: i=1; AJvYcCU9dt8BM5+p7eEjCvcNkaSl4YvugIzzomHPfhJ7Xednf0fbIOUdOcHGEm2eOWTPT2N/zcdSWN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWw261xibQ/WVHPdGmdRw9Y0jupRRxTZ8CO+wzhDy0GJOPWO1H
	1EDmeaR4jT+SbeV+c1MEoI05VQtiQWnyn6Dnrp6eFKpWjvH0eNOMVXRmnkGE8yh+NR4KbV0zpW4
	IBWpMf0q1LQUzSUFPmMB4YsxOxjRgaoiY0SZ3ZPOi
X-Gm-Gg: ASbGnctyoTWX6nIhNnYcEe0PXXR2L8K61XGQGR1WL38oExI09W2jyYvO011Gn/CCXTo
	uB40k7EwzE98idhtEx5WbSEMJKEUtN1dnfivY7bCC0euBWcEq9/OjUVm4nYMFBowqvjhCHeeN72
	BhiRJ5i2q9vRtcJGUWttFQB1/K4kCYa8zFh/l9DR4ilFlL27llPuFH4lGTusbCysWJ8zTP1dOVH
	y+kT9duJMoTmDaj+DujJRIjxG+m3LKAZtWWsqnV0MV0CM2md6pcBuMuhAMQ4zc9eGidg7ucjdCJ
	lztm9p6A0viyQw==
X-Google-Smtp-Source: AGHT+IEqOac+BFYpxfM0/uO36LtiOuNfPOYc5xaD5nOBsqTV/iFqdEYsjiW7QKEkeeq6eJD3nbzdYW5oq57rIKceRv4=
X-Received: by 2002:a17:90b:5183:b0:341:2141:d809 with SMTP id
 98e67ed59e1d1-34733f3d481mr7005864a91.26.1763832294239; Sat, 22 Nov 2025
 09:24:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110123807.07ff5d89@phoenix> <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com> <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me>
In-Reply-To: <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 22 Nov 2025 12:24:43 -0500
X-Gm-Features: AWmQ_bnWz70tEA_PHxhbkiZ9FEAU4DfGsk_s0DtN1pn3FeENFXUZhpYAqSk5WBs
Message-ID: <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com>
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
To: =?UTF-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi =EC=A0=95=EC=A7=80=EC=88=98,

On Sat, Nov 22, 2025 at 1:56=E2=80=AFAM =EC=A0=95=EC=A7=80=EC=88=98 <jschun=
g2@proton.me> wrote:
>
>
> #!/bin/bash
>
> set -euo pipefail
>
> DEV=3D"wlo0"
> QUEUE=3D"1"
> RTP_DST_PORT=3D"5004"
> DUP_PCT=3D"25%"
> CORR_PCT=3D"60%"
> DELAY=3D"1ms"
> VERIFY_SECONDS=3D15
>
> usage(){ echo "Usage: sudo $0 [-d DEV] [-q QUEUE] [-P UDP_PORT]"; exit 1;=
 }
> while [[ $# -gt 0 ]]; do
>   case "$1" in
>     -d) DEV=3D"$2"; shift 2;;
>     -q) QUEUE=3D"$2"; shift 2;;
>     -P) RTP_DST_PORT=3D"$2"; shift 2;;
>     *) usage;;
>   endac
> done || true
>
> [[ -d /sys/class/net/$DEV ]] || { echo "No such dev $DEV"; exit 1; }
>
>
> if ! tc qdisc show dev "$DEV" | grep -q ' qdisc mq '; then
>   echo "Setting root qdisc to mq.."
>   tc qdisc replace dev "$DEV" root handle 1: mq
> fi
>
>
> echo "Adding ntuple to steer UDP dport $RTP_DST_PORT -> tx-queue $QUEUE..=
."
> ethtool -N "$DEV" flow-type udp4 dst-port $RTP_DST_PORT action $QUEUE || =
{
>   echo "some flows will still land on :$QUEUE"
> }
>
>
> echo "Attaching netem duplicate=3D$DUP_PCT corr=3D$CORR_PCT delay=3D$DELA=
Y on parent :$QUEUE.."
> tc qdisc replace dev "$DEV" parent :$QUEUE handle ${QUEUE}00: \
>   netem duplicate "$DUP_PCT" "$CORR_PCT" delay "$DELAY"
>
> tc qdisc show dev "$DEV"
>
> echo
> echo "Start an RTP/WebRTC/SFU downlink to a test client on UDP port $RTP_=
DST_PORT."
> echo "Capturing for $VERIFY_SECONDS s to observe duplicates by RTP seqno.=
."
> timeout "$VERIFY_SECONDS" tcpdump -ni "$DEV" "udp and dst port $RTP_DST_P=
ORT" -vv -c 0 2>/dev/null | head -n 3 || true
>
>
> if command -v tshark >/dev/null 2>&1; then
>   echo "tshark live RTP view :"
>   timeout "$VERIFY_SECONDS" tshark -i "$DEV" -f "udp dst port $RTP_DST_PO=
RT" -q -z rtp,streams || true
> fi
>
> echo
> echo "Netem stats, see duplicated counters under handle ${QUEUE}00:):"
> tc -s qdisc show dev "$DEV" | sed -n '1,200p'
>

Thanks for the config.

If you can talk about it: I was more interested in what your end goal is.
From the dev name it seems $DEV is a wireless device? Are you
replicating these RTP packets across different ssids mapped to
different hw queues? Are you forwarding these packets? The ethtool
config indicates the RX direction but the netem replication is on the
tx.
And in the short term if a tc action could achieve what you are trying
to achieve - would that work for you?

cheers,
jamal

