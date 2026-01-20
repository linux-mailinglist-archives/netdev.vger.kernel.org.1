Return-Path: <netdev+bounces-251424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD5D3C4F3
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE1AC58243D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68A3B8D67;
	Tue, 20 Jan 2026 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fy+sCTb3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408A33E36D
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903251; cv=pass; b=IuEM5/Wt/x1QO8GDVGrxfZZyKyUShCtI29NTrcdY+noSgrXk2FsMM/A3KpSjoGa2IKVFX1G1FE3MOGaInAuLpsPqhCOQHXNkAfj9/5xfZh3QEY3HOQrNjfv48ZLlYX409DcemYZNzCflYkDdV0d3Sl8tqAeJCJW8roCyhlt3Vg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903251; c=relaxed/simple;
	bh=bxs1d0ToON+/Bp2OpxrCQltJoJYi6G5PLdJ09NcDoJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scmEFc/Z5g/phaUoAQr0NUU2q4kUO0yTwSDDBLPNrWfZo9G8+dBUQQLtcExJqlDlLJYJ9mxkPhpp3NZ5d/vbuKewMr43q82qj50ZfHhcEUGvqiHC+Jp9pEX09f7mFAAarkaImFSXTccI+tKtvCGtcr2/wrnwZdG+D8w1vFjaw7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fy+sCTb3; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so931190eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:00:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768903248; cv=none;
        d=google.com; s=arc-20240605;
        b=k4s0+WA+k1/Gx39yI8yTooY2koG9I77olFlo8qnLmJ2ownmvhgFOxlDwQS6v+iEOUf
         KQW9SpCZ2l+Nfi/CeTcsQ71CYbtfMRiBzlDnh1qqdIVlsZzzAOAxuaPLIem1Qb/oSIKF
         M5Am5gwDAvl726kzN95i/0oWX8iFDqWi2HA/GCzCEgqAOq3q0xb9nVgmDQ1RykGQkiIx
         cM7QQszEOQ53huqJQLEo5X5gqHEOv3jQbgq8kmhgkb6wbQPc/giG11glrCr1JtFqi0ka
         Y5utYmg9V5pCdYBqiDMgemmJsP2sATFjaJalhkIQCoCNODEHVUlC5QD58JMIgsj3Gd7+
         AErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        fh=W12W81j/JVi6+zU5aOwyiHnuhKz+4toJaMsHWvoXIqU=;
        b=kmeMmzyhGBQQhSMTIB5sQcYO1MfE/6bGhGwZ9/VIrZaHTKI1yBXlcM7DDp+l2/oK0g
         wftldBeyQCRBhlCsuYZFh+eKe2YusdciLyW/9VgLlXbtJgPTBtbnEeuI8Le5cnlyZ7bI
         oVYy+EvzaehL2s7RbjPRmFmePgtuzTLywG/Oii/FT0+TgQ6YawwvCss+ZXNhMIBHSmHt
         k+Bk0TX23tqf1qpYZhbB+xYChqR2Vf+9o8UTvXxltYmKxIVYSUhQKJhxtvkoLoSdy49u
         CGuZWLEf1uEuOrpfWSKGYz3d2v4srTPunCr1FeCtpfpUjviGhgKqXc1bbFlNf3fl8LPa
         2T6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768903248; x=1769508048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=fy+sCTb3kVT+bwkaQybMAlNnh7JusRPM3IBRtWNPvbZgSshwnq7HycHUwjs93fuwU8
         SfzpvpkPt+WNa+O14RgMpQgg25XJG54RMIlsKghtI1peokZlwO3XijMpzIxf8TMpgSWE
         NMIW68ho51Ty4YWAJwr4eGaNeEKOiKAM480V3l0TBanJx/uOw7vkv+n08ZSh+hp1bdQE
         ZwQ7YcURj8s14VhfRVpBuZX10CtmW8w/48c5FFbzzHv/hnOnXRIWNnkXbfp9Gv7nhwPz
         1wxKtioT64b/nCx6m8730np+U0lzrzyNEGId+gTlDDQw+MXTba58XbV/t7WISigBXYwD
         PKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903248; x=1769508048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=mbeQa2lDcOK1NUtwKe2TZdlz52mUjZu89ZqzU1fDhJoOvSEMoVZL5Zob5iyzXGHmpJ
         /V9PFqleQW2CCk4aiAvDrXaGnoUUV2vwkRjPdLoWZHJ12lnsxDG6+HetScXPx97wLKaM
         MUSoTsLKM1WnuU8llN6eCJOXletzvETguCHRaEd1pcdE1VmN0ge30ZgPKecjB4g8c0l8
         QVhMfdIyg1XTgDzBX4D8y15vcsQnuMjSUjLsPtURYmzo+2j+iqKZUTlFI2y7fbfylMq0
         +VCFZD7748RqAJoH2sVl74e5H6VWt9QFXkbR0nC98ezleBjW7GEePRHDYQS9JDH1Wy76
         NTCA==
X-Forwarded-Encrypted: i=1; AJvYcCWWc6BJpee8MFc+KF7x8Uy1V5zjoTjzO+A24wMGMHStIRG1bN+OkiJo84Gv1EWMvDbmm5Jv5nY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqhh17jUsuz/71+muIcqDVni5qAfzsePgX4AEJ9NfyQz04868B
	Yjm45vGx36eqRQHq9/QAcTXWumq+D+fitRtKOUR02hA4G4h4sRFCwlv7DlUuofeRmn2gozguwrE
	o3OYD38S+hvRYlO0s/pA77ySsjx9yWAf9A84yoY/3X1mKUf4fskxkSYlmvb4=
X-Gm-Gg: AZuq6aLFqUDGZ4YtoAYJtzc2IkuGDw7BEOcLB2Kx/X/td+8EShy0S5XiWXzw7DeiyGr
	aD6Z6zQ4RFIDRwHXIQwRnteMkKjUHp+iIctyrouB01JIJJ1kFtf89fm4541BrJpDnos9UAIa/BO
	zlDeX7IqHV4MRqzG/AKrAg9r0mQ4M0vybXG7EOOnWUpdYWT6EDcGh5dAiTD22uUiU8W0aOmvcG5
	vT7gAFJTjEqjSGKYtYSlLDI1vNnr2Gy4CJeMcHz0aEyqoWZx6PP+auSgF854FHh/0ituxI=
X-Received: by 2002:ac8:7d45:0:b0:501:4a4a:c24e with SMTP id
 d75a77b69052e-502a160b06fmr183731541cf.25.1768902839039; Tue, 20 Jan 2026
 01:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:53:47 +0100
X-Gm-Features: AZwV_Qg0IWXghbxwuvPJvSjMMI2uFuU_uwIEWxMla7dfzpOOQkjvRiJt8IywSHk
Message-ID: <CANn89iLzynvieqZUVK3NqaSpMT=-toZ1M4QHvQin5gHQM7T8yA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Two CA module flags are added in this patch related to AccECN negotiation=
.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
>
> Second, during ECN negotiation, ECT(0) in the IP header is used. This pat=
ch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-se=
gment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT v=
alue
> in the IP header by the CA when not-yet initialized for the connection.
>
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN=
 spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

While for some reason linux uses icsk_ca_ops, I think the terminology
is about "CC : Congestion Control"

Not sure what CA means...

Reviewed-by: Eric Dumazet <edumazet@google.com>

