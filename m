Return-Path: <netdev+bounces-197713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99693AD9A56
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E1C189D281
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 06:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D821D63F2;
	Sat, 14 Jun 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmMoI7d5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241283594E
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 06:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749881885; cv=none; b=rSXp4gcvPiSdmNznY4LB+akvMVSeh8VR0ze3f2Krcn7gs83iK2OCU1B4lBBRMrZG2UIiJH05NqqjLBxnNa3UZDpzJSz8n7nDBZkk6v23aKCwZvG6hrCQ+gUV+mf62oVZwgRmZEG7WCykZ48XQ5kCIbZgrvmJBX212F00jQvp5pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749881885; c=relaxed/simple;
	bh=NoMhAH2FgHzUlmF94BRTu04p9+hoVCS7I9TNhFd0qAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atjBSyon8qHy03gjorl+e1zPDZlgIObvoFGozF7iubVd6ktCZjCpKToHwRqNUS7O1z0KOUZ/oR/duaHPdZK4VBLNE62nzZY6gEPSu/wJlUqcZM/poTx5AoFgixsL0ZT1tvhiHJczb4JBgwmurFo31MCbjCqBdELVBLjxkDkoK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NmMoI7d5; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a4323fe8caso21155991cf.2
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749881883; x=1750486683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c2joS0GB6217KwOLu/ZECbOg7xeoRqJmZnYVLmbhOk=;
        b=NmMoI7d5DE7touWiZshc+08wWCK1S7IX5PpNw7IZuz2SDsWI9Zx9yFlYltsjLWvtHZ
         odiu2cgAAfm/YjfXdSilZbHlY/2eiXp4u/DCxoH4zTLQsgMhxaD+h7ktkrhtUTQSMCfP
         r0mZ935GZ0QVR8Xgr4GEebzZm1CQjmGW7kq7f2Ty8CUydsWTeKGEEGU8zmqEVfSJTKT/
         QlTRp+/0Iyigcg/xC+pZhZrVGN1e7OWZdWtbPoW1DHL4yi0w/hNRCe/oHX/Jq0pW7Ehd
         ofF1xGtMEbDq3wIG3Ya5ES45lXYEBkkzgALp5av2Jdxt3SkzGwjL6NaNd1pqNtTfjWJ5
         z+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749881883; x=1750486683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c2joS0GB6217KwOLu/ZECbOg7xeoRqJmZnYVLmbhOk=;
        b=MdaSIANondnovFhtPqI53I5i5avgHuJ1r70QKLHByTxymdCOc4+WTiHG5Zj0ZY6JET
         Iq7bNylDN6jEwApJ5jdG1EF13Lz+AbsindErtqwAQhbqmxrRD6WkPpQ8PFO5u5kOLiGx
         6hrfiY044kTW9zUmZ5LbgHQ08sWv4SNgAUplnN9MN5QjusV1Zh4YCCm2hk030ww3Z1Fg
         0JhYQSOJ9qczOL0Xilz9QJ9U9VC1Tf5GjXLy+5knjgaY2hbRickNRGmAL4jfdNmfrkMX
         krrDdCG7isiA3+GPXRNiJS+4BGVBZ5gqBFEB4OzxdVSG05uRvPZo2b36EbveVDCK4yfm
         Af5g==
X-Forwarded-Encrypted: i=1; AJvYcCXi8E7bQHUKFzvJVMgWXV4qWBUvubH3/tEYyNodGRcHyg8ZyHBvX52IpsRhNrdOQ6t+OLfFIDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgr4URBK0GXUXUc52bY8FcIwBtMIvwsDOUlkHN+CNafnYWK4J8
	8EP9+maNJKMLow5uzvGRrBz8C78LBWSlywbeXavNEmRwupnGwzSEJGdri5kYNgaLeDI/Kq1PBJg
	m+IgAQxhvr0dIxFALCTWbMgbn3gSX2UgaBE+d/FuE
X-Gm-Gg: ASbGncsWwa4TDg0yAbagh3MVBnn8m1+PKr8Ha2Tc2KtCtMK8chWP6/ux606yQjTxe4J
	6UyWRq6M67PGSZQGfmMihkE4DF4JJxkzQgZTCB5YobRA7vBhB9lUM1PRtK8pLjfdAGPr/rN6rMB
	IGg/vnu+0HDWN+C6Huql6h9pANcCq0ZczvzQmPOBtQLWA6
X-Google-Smtp-Source: AGHT+IFO1Q0P5SdpHcJT0igDcvgJniTq8k8Fm0etjyTcmT0ty8gLNEJ6536ziXHCrf++VO+han5z3oqIhPnwoHa/jPc=
X-Received: by 2002:a05:622a:488:b0:4a4:3e89:d5c0 with SMTP id
 d75a77b69052e-4a73c4bec58mr26492321cf.12.1749881882614; Fri, 13 Jun 2025
 23:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613193056.1585351-1-ncardwell.sw@gmail.com>
In-Reply-To: <20250613193056.1585351-1-ncardwell.sw@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Jun 2025 23:17:51 -0700
X-Gm-Features: AX0GCFtqgwdN0d8yM-nHgkzG9-icb2hWbpZ-eiXEnTUhmgnzcMVj3aYGiYnHk8Y
Message-ID: <CANn89iLFNDh1gbAXgS5XVUhjRz8NX9Gsrymcnv7A-SB1s2wpqg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen()
 behavior
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Eric Wheeler <netdev@lists.ewheeler.net>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 12:31=E2=80=AFPM Neal Cardwell <ncardwell.sw@gmail.=
com> wrote:
>
> From: Neal Cardwell <ncardwell@google.com>
>
> After the following commit from 2024:
>
> commit e37ab7373696 ("tcp: fix to allow timestamp undo if no retransmits =
were sent")
>
> ...there was buggy behavior where TCP connections without SACK support
> could easily see erroneous undo events at the end of fast recovery or
> RTO recovery episodes. The erroneous undo events could cause those
> connections to suffer repeated loss recovery episodes and high
> retransmit rates.
>
> The problem was an interaction between the non-SACK behavior on these
> connections and the undo logic. The problem is that, for non-SACK
> connections at the end of a loss recovery episode, if snd_una =3D=3D
> high_seq, then tcp_is_non_sack_preventing_reopen() holds steady in
> CA_Recovery or CA_Loss, but clears tp->retrans_stamp to 0. Then upon
> the next ACK the "tcp: fix to allow timestamp undo if no retransmits
> were sent" logic saw the tp->retrans_stamp at 0 and erroneously
> concluded that no data was retransmitted, and erroneously performed an
> undo of the cwnd reduction, restoring cwnd immediately to the value it
> had before loss recovery.  This caused an immediate burst of traffic
> and build-up of queues and likely another immediate loss recovery
> episode.
>
> This commit fixes tcp_packet_delayed() to ignore zero retrans_stamp
> values for non-SACK connections when snd_una is at or above high_seq,
> because tcp_is_non_sack_preventing_reopen() clears retrans_stamp in
> this case, so it's not a valid signal that we can undo.
>
> Note that the commit named in the Fixes footer restored long-present
> behavior from roughly 2005-2019, so apparently this bug was present
> for a while during that era, and this was simply not caught.
>
> Fixes: e37ab7373696 ("tcp: fix to allow timestamp undo if no retransmits =
were sent")
> Reported-by: Eric Wheeler <netdev@lists.ewheeler.net>
> Closes: https://lore.kernel.org/netdev/64ea9333-e7f9-0df-b0f2-8d566143aca=
b@ewheeler.net/
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Yuchung Cheng <ycheng@google.com>
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

