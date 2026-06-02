Return-Path: <netdev+bounces-294368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gl2bA9kpH2pCiQAAu9opvQ
	(envelope-from <netdev+bounces-294368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 796726314BE
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=jDY90QfF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294368-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294368-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3AEE303C2B5
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4873998B7;
	Tue,  2 Jun 2026 19:07:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C930C3A48CE
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:07:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427222; cv=fail; b=CQ5liYyrtPS/ChH/QJKdbpqb632KAq12JFu2vo0C7g1EVAzbFVmEkFuSDGr+hx4ZrVv4qf/AKrP0tRz/9iCiLjfK5tzxFSePUu5YB0guBjDThB/WwdUZY6Wn3fxp0kR5njRP/vH1hxih0CUOaPu0hInIkynQxlEpt9uTrP0AFHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427222; c=relaxed/simple;
	bh=PchiZHbJted883YM7Tsx4MCanuIBbvFzBfb6R7sdrLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZzp2mpXd5apSHpILlhtqJDeCnTMD2PrjZWKwLErpAXBYeLKH+12a6fZGK/qC/wPbUPhwb5tAFjykQ+49AG6/WfFt208wwaENdYXXU4RwOGmazXKdcxjVMm00gm2qVVRkJ7Q0a5uyW1T0V9fyvK9cmVrkAzD3ZjR387R4m2b3yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jDY90QfF; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 652EQmek1101920
	for <netdev@vger.kernel.org>; Tue, 2 Jun 2026 12:06:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=AmdQqVczB19sGPldwgj6uwVjXHVUoAPkK4whM3xvMNM=; b=jDY90QfF/s6g
	fk1kSwdakA2kyRatMGd5fXtiCwXtbKpXtPrggdCmTCU/5xXBhb/ALSCktzJKFzhg
	x59KnhFGSJRROfNHqUx73LpxJLa5z0T2xcwwbZjmCCWkdKxXJTwcR7sopaMSbAhP
	R1eUiexPqWZi9XiS/QR2A0GIfoiXLkfQNRzGG45HeaAV2+yym/NbHznSDRXetfzc
	psTmX7drT0+T8HaK1VX9g/39Qf6zY/VLeKRyOUuq/8UIHPbj9wfauh1YpBkcviZs
	RVTZUscLbU6Pr/z0MVl3NqiD5Bezz1FeFitWXS3roU9WfPtb6lrEmxXKepd8NoKG
	2PwViZfK3w==
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	by m0001303.ppops.net (PPS) with ESMTPS id 4ej0xp200g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:06:59 -0700 (PDT)
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bdad545342aso980095466b.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780427218; cv=none;
        d=google.com; s=arc-20240605;
        b=XUC0O29cElz0Aqj6LTs+GgVJu/1WksojX973VmHVsI4ZoPf2z2CoWOYFuRWa6oE0Ok
         QHlF5uZGoMCJGecP9CwEHHzii+gdamxr6x8qXHcwZJcuW0eAvpoJ4jy9mvlRal8uN9Ai
         fkS+nudRzqjnHxruVlbep0FHbI/tvBcF9HCqZlJXwShjZB8SKo/HAGQkGiVqyxE3P7By
         T43qIvsEBLqyE5JNZb/p3jCdTEiytQwUIaa8u+cd770qZhhA1oQB2V8RU9+35ixRpCYm
         ywDoncg2a6gU1IoypznbqfxEi2qknJ2gzQMqEfUMUnjdau9WKoH6E6+We5nzomWwK8jz
         h6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ffyFo/iBrLC5gQgtLpPm5hjGbuSJyPD78waGPloq+jw=;
        fh=5OjWn7i3wpFahJlHl/K0dHDB+0wA9j0mo0bJlozA1kE=;
        b=U9ssW4U5gcYMi3uAwRnmLLnpY9RzTOvBiQIgFq/5TSjY7fyHcuPaHOcdW5HGtpouZu
         Pq24NWdjnDuOIbtxFgCZO0ZHbxgHpr2PkYZ8iAFgm72ufNF8dMZ2CW0KtmNiBwFzSTo9
         JPjYGDBNmielV6kOd1igZIguHIObgykcnS445qk7OZ3UVIm9IjoBox+EvvOp7Rgdk1Z9
         BHCw3ST6eZIEN8w/RJAgUTVNKiwPGm6BKLkr6YI3riuTwB+wyJU7kMKkCYWIeUXQtN9o
         pNVE18hS/jIZePals9f71x8IHLZnXmtZc7MeQ1rbu2YVtmSVFPrtt8eyC3J0JOtiho7l
         Q6SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780427218; x=1781032018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ffyFo/iBrLC5gQgtLpPm5hjGbuSJyPD78waGPloq+jw=;
        b=opC1lQcZmzhjO12DqNGF8/4CFFs2MBmX/PKj8+a1abNlxDeml9IbIXNKj0VC4vtPoA
         oyAj5tYWUN7RoXVnp3pTs8WrfG6VWT+qPSyFib/xibyvaXUwyLc2nS0owlfNSJ8qfTf2
         Y8dx2Yo3y0mex22Y3HcHNzDVgauUE86W4hpqkEkYldQuP1GmtggG2mxfrsjVqphVlBgi
         hz1+Myk7uYNHY6RPGa0EMt8PFTy7Kh3Qdw9bDwJm4M9LjMOHV2+ovt4LdTO1jnX62iHi
         T0exQG4d2yt70SbCgjYWuQdyqSjM5QWh/3ltZgmgInLj6tqZv+RKqpM1UXu/rNu+Up0D
         Nkow==
X-Gm-Message-State: AOJu0YwsQeC+BXBlkbAby0IPbngA/K1pYIVdfg9p3P5tJIdF7acI5kfw
	uCnVkHGGflBSlvQTsPWd+pzwHFwBEmt8GHm/wu+nN9kgFqmIDOi7j4lNmC10Vs2SjpEtiv1iNgA
	xwwxCWrrtyEpeFVrtyyTzAS0wf4LkdGyKEsmN/EZT0nw9x0v0HkVMFIVzD2IPtEse3LvySX2hfc
	pkXiUX/Kx81pgm2lQx2V1PqeU0cJtODw==
X-Gm-Gg: Acq92OF4vB8XeBpotjNS6bvaRLbwhMzH0kS6aN9JiFlNCtwKhTpv1zUzr/5XamRjL0J
	TpRy9j0HoBOSBVuwKdrpMib33Zyh8F34mqVZBuCKC/3jkGKaqhBKLWMVagZGo8jDSvOoTjfNv+b
	ajhpYdjoQkr+mYpR+x8ZAuzFrv+bOCcNvcfXk4UYRshQ/05QjtPatDLEfVugxQNMnUrNk3+G/AB
	0Ow5nU9h6BE/18F/A==
X-Received: by 2002:a17:907:fd8b:b0:bd4:7bed:512a with SMTP id a640c23a62f3a-bf061812fd5mr57147066b.30.1780427218276;
        Tue, 02 Jun 2026 12:06:58 -0700 (PDT)
X-Received: by 2002:a17:907:fd8b:b0:bd4:7bed:512a with SMTP id
 a640c23a62f3a-bf061812fd5mr57145066b.30.1780427217854; Tue, 02 Jun 2026
 12:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602181428.2318919-3-ntspring@meta.com> <8ac88be59633fbdf71337c80ecad1a268a989440e8865df3ef6906d33bbf0837@mail.kernel.org>
In-Reply-To: <8ac88be59633fbdf71337c80ecad1a268a989440e8865df3ef6906d33bbf0837@mail.kernel.org>
From: Neil Spring <ntspring@meta.com>
Date: Tue, 2 Jun 2026 12:06:31 -0700
X-Gm-Features: AVHnY4I9E97vtJNAItNoiDOxUpsvUBDTWw2Z8iM1jvir4KetPOYHnRI2Ix4qyAE
Message-ID: <CAGy2EQajXgkqBbYtwCF9qXquHOP7mkLR8MQ+gg-cDjKw+z51KA@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] selftests: net: add local ECMP rehash test
To: bot+bpf-ci@kernel.org
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
        kuniyu@google.com, davem@davemloft.net, kuba@kernel.org,
        dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org,
        andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=ZPHnX37b c=1 sm=1 tr=0 ts=6a1f29d3 cx=c_pps
 a=edIAN7ErZTGbxav20d8A7Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8
 a=2M8aKpgkrPwFO8N7dvUA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: mnDkUzEPP2lssVClo0Lyknashgx31JDS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE4NSBTYWx0ZWRfX/fYEtxL2arFP
 U2bMW/vYiHYvvX+Je9rc6pA0lQY5PJp0mBqq1bqCYFSLP9QmF7IvTV2b0WJIbuKPUZ4IvoPpYY9
 q15YcX2A5hDBqNLwW+spK1Hx0o3AcGXd6tp8o7mvDwmmUsiWf0lcQMmHKcyXTX12ZPFMi3uZB8M
 p+zaC7qjWOmufZvR6nl0vWv+GnpCxmEuNQ/EYz3jOTudM/2ToSomA0BD3vwTUI1scg4M6Hx6xhr
 B3B+snk/1B7mSXnkwVVaCd/xdeMOQAHyt/nnbALk0UmUpe6zk2SRuYodbSDEZXUGQV/BADpsyaV
 xaRt1NCcliqLVNUVC869B9iqVzPCjBYXyOgdtMRJDmHiR9Omd59m85mvBCQGhF2UkjBnjOtWPrO
 64fgj2fCAb5rGSKl1TPOUQFA6t3Crr5y91BWjj6SQkXUbkM3N9Bc0fyOuerx6nwb+o2AUrbsGFV
 YHkIkN0u8JsGaempHLw==
X-Proofpoint-ORIG-GUID: mnDkUzEPP2lssVClo0Lyknashgx31JDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,m:ast@kernel.org,m:andrii@kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294368-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,linux.dev,iogearbox.net,gmail.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ntspring@meta.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[meta.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:from_mime,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 796726314BE

On Tue, Jun 2, 2026 at 11:43=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> >
> > diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing=
/selftests/net/ecmp_rehash.sh
> > new file mode 100755
> > index 000000000000..ffaacf1d9513
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/ecmp_rehash.sh
> > @@ -0,0 +1,1066 @@
>
> [ ... ]
>
> > +tc_filter_pkt_count()
> > +{
> > +     local ns=3D$1; shift
> > +     local dev=3D$1; shift
> > +
> > +     ip netns exec "$ns" tc -s filter show dev "$dev" parent 1: 2>/dev=
/null |
> > +             awk '/Sent .* pkt/ {
> > +                     for (i=3D1; i<=3DNF; i++)
> > +                             if ($i =3D=3D "pkt") { print $(i-1); exit=
 }
> > +             }'
> > +}
>
> These per-device tc filter counters match all TCP IPv6 traffic on the
> device, with no isolation by port.
>
> [ ... ]
>
> > +test_ecmp_syncookie_path_consistency()
> > +{
>
> [ ... ]
>
> > +     for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
> > +             local port=3D$((PORT + 3 * ECMP_REBUILD_ROUNDS + r))
> > +
> > +             ip netns exec "$NS2" socat -u \
> > +                     "TCP6-LISTEN:$port,bind=3D[fd00:ff::2],reuseaddr"=
 \
> > +                     - >/dev/null &
> > +             local server_pid=3D$!
> > +
> > +             wait_local_port_listen "$NS2" "$port" tcp
> > +
> > +             local srv_base0 srv_base1
> > +             srv_base0=3D$(tc_filter_pkt_count "$NS2" veth0b)
> > +             srv_base1=3D$(tc_filter_pkt_count "$NS2" veth1b)
>
> The baseline is snapshotted here, after the new listener starts, which
> handles leakage that arrives before this point.
>
> [ ... ]
>
> > +             local srv_tcp0 srv_tcp1
> > +             srv_tcp0=3D$(tc_filter_pkt_count "$NS2" veth0b)
> > +             srv_tcp1=3D$(tc_filter_pkt_count "$NS2" veth1b)
> > +             local srv_delta0=3D$(( ${srv_tcp0:-0} - ${srv_base0:-0} ))
> > +             local srv_delta1=3D$(( ${srv_tcp1:-0} - ${srv_base1:-0} ))
> > +
> > +             if [ "$srv_delta0" -gt 0 ] && [ "$srv_delta1" -gt 0 ]; th=
en
> > +                     path_splits=3D$((path_splits + 1))
> > +             fi
> > +
> > +             kill "$client_pid" 2>/dev/null
> > +             wait "$client_pid" 2>/dev/null
> > +             kill "$server_pid" 2>/dev/null
> > +             wait "$server_pid" 2>/dev/null
> > +     done
>
> The client and server from each round are killed at the end of the
> round, but the loop moves straight on to the next round.
>
> Can asynchronous teardown traffic (FIN/RST/ACK) from the killed client
> or server of a previous round still be in flight after srv_base0 and
> srv_base1 are snapshotted for the next round?  Since the counters match
> all TCP IPv6 traffic on the device rather than the current round's port,
> would a late teardown packet on one path plus the new round's traffic on
> the other path increment both srv_delta0 and srv_delta1, satisfying the
> srv_delta0 > 0 && srv_delta1 > 0 check and recording a spurious split?
>
> Would a short quiescence wait or filtering the tc counters by the
> current round's port make this check more robust against late packets?

Yes, thanks; fixed locally and will appear in v12.  Each round now waits fo=
r all
active TCP sockets on the port to close before proceeding to the next round,
preventing late FIN/RST packets from polluting the next round's tc
filter baseline.

> > +     if [ "$path_splits" -gt 0 ]; then
> > +             check_err 1 "$path_splits/$ECMP_REBUILD_ROUNDS had split =
server path"
> > +     fi
>
> The same pattern appears in ecmp_dst_rebuild_loop(), which also relies
> on these global per-device counters across rounds.

This was less of an issue since ecmp_dst_rebuild_loop had a threshold number
of packets that a stray connection termination packet would not reach, but =
the
same wait doesn't hurt.

> This was raised by an automated review on an earlier version
> (v9, https://lore.kernel.org/r/20260530004914.C05121F00898@smtp.kernel.or=
g )
> and the counter structure is unchanged in the current version.  It
> affects test reliability rather than kernel correctness.

Apologies, my error.

-neil

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/268394=
85409

