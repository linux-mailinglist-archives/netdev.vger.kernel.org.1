Return-Path: <netdev+bounces-306046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YbuyNPw0T2pscAIAu9opvQ
	(envelope-from <netdev+bounces-306046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 07:43:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0663272CD3D
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 07:43:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=gjsb3iVN;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306046-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306046-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10CC03024183
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 05:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339C3A7858;
	Thu,  9 Jul 2026 05:43:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182C3A9637
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 05:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575802; cv=none; b=rDgd3WIWuMAW/ZBsgTI+D3efZtyS2hN2AyypNwEJit2vrzQpL0cWvW13Ch+o3wFzUHHLuAK9v8q22EZvrwF+vWIbozZODSnGTaYZAIpMaNcz4dxqyWnoJ5DvwdbuE/EjeZuxfc6tbzcERb1Xq6TpX+Vis/wh4v/htQ7oHhOQpO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575802; c=relaxed/simple;
	bh=6h5p7n5No64QiJEYCYCEU+E9AgD/KFjcbLGyq0ar2ak=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bpF6qtFRPqSzFLHsJf7dGwyPUTRtPaA+AS9rdW9ohvGfgeCNY38G18m7ogxGJG66XIRCec09JllswAMQCb1Zgm3B3bE9dq64UIVBXtpdLDNe1u6m1Z6P8RZcsyL3shDTyxlZrwA7eql27zT451wd+x0z22ilsqcpq6tx9VDrJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gjsb3iVN; arc=none smtp.client-ip=91.218.175.173
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783575788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OifTvRzURu2dVot9IJ7DSNor84sK2OfO99KNA1PqW3o=;
	b=gjsb3iVNpJg/gmcCx0Qy34R7WBozs3vsPK68JOyg0MagmcNwIFUdHKAhk5RsQVcMXghLDw
	tp+20OZUINZu6ZR8ZPElq2PdqMK/UlIrl5nJOKYjUVv6dB2RgilM3FFLUrd/g6/MwnL3QL
	8RDGR/CLBTvt6R47KXfJ8MyOaSELXyY=
Date: Thu, 09 Jul 2026 05:43:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <8155514655323d8c4a07da86d2b2ccdd7244c125@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
To: "Michael Bommarito" <michael.bommarito@gmail.com>, "Matthieu Baerts"
 <matttbe@kernel.org>, "Mat Martineau" <martineau@kernel.org>
Cc: "Geliang Tang" <geliang@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260707171730.2679013-1-michael.bommarito@gmail.com>
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
 <20260707171730.2679013-1-michael.bommarito@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306046-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[gang.yan@linux.dev,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gang.yan@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0663272CD3D

July 8, 2026 at 1:17 AM, "Michael Bommarito" <michael.bommarito@gmail.com=
 mailto:michael.bommarito@gmail.com?to=3D%22Michael%20Bommarito%22%20%3Cm=
ichael.bommarito%40gmail.com%3E > wrote:

Hi Michael

Thanks for the patch.


>=20
>=20mptcp_get_options() clears only the status group of struct
> mptcp_options_received; data_seq, subflow_seq and data_len are filled i=
n
> by mptcp_parse_option() exclusively inside the DSS mapping block, which
> runs only when the DSS M (mapping present) bit is set.
>=20
>=20A peer can send a DSS option with the DATA_FIN flag set but the mappi=
ng
> bit clear. The parser then records mp_opt->data_fin while leaving
> data_len and data_seq uninitialized. For a zero-length segment
> mptcp_incoming_options() evaluates
>=20
>=20 if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
>  mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
>=20
>=20which reads the uninitialized data_len and data_seq; KMSAN reports an
> uninit-value in mptcp_incoming_options(). The stale data_seq can also b=
e
> fed into the receive-side DATA_FIN sequence tracking.
>=20
>=20Record the DATA_FIN flag only when the DSS option carries a mapping, =
so
> data_fin is never set without data_seq and data_len also being present.
> data_fin is part of the status group that mptcp_get_options() clears up
> front, so on the no-map path it stays zero and the zero-length DATA_FIN
> branch is simply skipped. A DATA_FIN is always transmitted together wit=
h
> a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
> data_len), so legitimate DATA_FIN handling is unaffected.
>=20
>=20Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state ma=
chine")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fi=
n
>  at all unless a mapping is present, rather than gating the consumer in
>  mptcp_incoming_options() (v1). data_fin then defaults to the value
>  mptcp_get_options() already clears it to (0) on the no-map path, so
>  the uninitialized data_len/data_seq are never read.
>=20
>=20 net/mptcp/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
>=20diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index dff3fd5d3b559..6d003b24b969f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  ptr++;
>=20
>=20 flags =3D (*ptr++) & MPTCP_DSS_FLAG_MASK;
> - mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
>  mp_opt->dsn64 =3D (flags & MPTCP_DSS_DSN64) !=3D 0;
>  mp_opt->use_map =3D (flags & MPTCP_DSS_HAS_MAP) !=3D 0;
>  mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
> @@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff=
 *skb,
>  }
>=20
>=20 if (mp_opt->use_map) {
> + mp_opt->data_fin =3D (flags & MPTCP_DSS_DATA_FIN) !=3D 0;
>  if (mp_opt->dsn64)
>  expected_opsize +=3D TCPOLEN_MPTCP_DSS_MAP64;
>  else

One minor thing I noticed while reviewing: Sashiko previously pointed out
in a comment that the 'pr_debug' logging 'mp_opt->data_fin' might be
problematic because it's printed before data_fin is actually assigned
(since data_fin is now set only inside the if (mp_opt->use_map) block).=
=20

I=20think it would be cleaner to move the pr_debug call after the data_fi=
n
assignment, so the logged value is always meaningful and consistent with
the actual parsed state, like:

'''
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b924209a9b74..f58eb24f4d35 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -162,11 +162,6 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
                mp_opt->ack64 =3D (flags & MPTCP_DSS_ACK64) !=3D 0;
                mp_opt->use_ack =3D (flags & MPTCP_DSS_HAS_ACK);
=20
-=20              pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=
=3D%d use_ack=3D%d\n",
-                        mp_opt->data_fin, mp_opt->dsn64,
-                        mp_opt->use_map, mp_opt->ack64,
-                        mp_opt->use_ack);
-
                expected_opsize =3D TCPOLEN_MPTCP_DSS_BASE;
=20
=20               if (mp_opt->use_ack) {
@@ -184,6 +179,11 @@ static void mptcp_parse_option(const struct sk_buff =
*skb,
                                expected_opsize +=3D TCPOLEN_MPTCP_DSS_MA=
P32;
                }
=20
+=20              pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=
=3D%d use_ack=3D%d\n",
+                        mp_opt->data_fin, mp_opt->dsn64,
+                        mp_opt->use_map, mp_opt->ack64,
+                        mp_opt->use_ack);
+
                /* Always parse any csum presence combination, we will en=
force
                 * RFC 8684 Section 3.3.0 checks later in subflow_data_re=
ady
                 */
'''

This change isn't critical to the fix itself, so feel free to let Paolo/M=
att and
other Maintainers decide if it should go in now, later, or not at all.

A couple of additional notes for future submissions (just friendly remind=
ers):

- The subject-prefix convention for MPTCP patches is typically [PATCH mpt=
cp-net]
  for bug fixes targeting the net tree, or [PATCH mptcp-next] for new fea=
tures.
  Since this is a fix, something like [PATCH mptcp-net v2] would be more =
appropriate.

- It's also helpful to include a Link: to the previous version (v1) in th=
e changelog,
  so reviewers can easily track the discussion history.

Looking forward to seeing more of your work on the MPTCP mailing list!

Thanks,
Gang
> --
> 2.53.0
>

