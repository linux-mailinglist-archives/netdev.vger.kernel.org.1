Return-Path: <netdev+bounces-253858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Nb1Aza2eGlzsQEAu9opvQ
	(envelope-from <netdev+bounces-253858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:57:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE69493F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B80F23038F1C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A035771F;
	Tue, 27 Jan 2026 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYpoprn9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D63559FB
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518595; cv=pass; b=Q8CDe9LKUVRVfPDeNTlh4/YsXN+IcAPrRbm+MC1XwEKuG2Ct68MJix10FrM4rBiPoTGcu6k/jeMJhBepCjF3xWiDmDeSur7pBP/ajKtXgx6znUQ9Qa+I8tdkNEUHDtou4r0NC4Bq4eNSSlh29rXfYlz3dnHu+F3jN+UaBtiHmu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518595; c=relaxed/simple;
	bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoSVfnzR04Vm8nMnQL4W6S6JvCF0lLtMaRVDB8njpnq2u5BEWoc82iUtCEnD6vRB6LAQmRkIdJuoAGelqmpwGQGag8Gug08Ms2vcTOag4/hSsv1bpmNLS8iA3tZybKO2N+mSFwqdK1ToVNWEuD+nEM+rRBzePHONQv62qJlsJ1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYpoprn9; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-503347e8715so1526411cf.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769518591; cv=none;
        d=google.com; s=arc-20240605;
        b=OoK7HleEA6KyNUWFUFkRjzs8RAWNkUWk2Jc+CHfYw4WA8HXr9LcvWaUpCFAM6CBxgD
         fHSVt1djRdMDU65LSwwhr4FZ+XrQHEB1JhL/pVndWAVYQ10Iio6hsLFw6WxkgF0wPB8a
         fSvHkigv6rauGcdnDJiTHPK4wJdI2NuhyD7QT+ek4RChcKvQ5Do6K7AYASlkrm/oBjG7
         HFu6k9h1nUUIY8pMADsMKy8QwHPWExsw/gPLto2ykXiaIRs4TT8SAtqKmx/4H7DR1rCr
         l6i1yrm1g0L4SIZ8wGGVDbawOZeOnpiAfgHbBloT2miQkmwvxYoyXg5YCvAXoXrcgXda
         AVcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        fh=cvH8mO0I/EnFtTlwx4RYZuJfvkYNY9kcmAc1VcXfrAM=;
        b=VvUMXhgt9qcjdno0E7mZKN1KlacxQpo9FZfUyBS3wGd4rAxFuaAxxou/8ic3BGFHO4
         H+dZzr5cElGjw+q0H1FTleUevgNOPK9y4Ron0qoxvFYTWqUMYCk6PZ6uDLAZkHZiHyoU
         am57p4er6zzx26SD2Y7YKG5piBpoNseLotxi6aMLhUeFU7JvPSaZSkN83t1n6360cHLo
         aarQrZuT0jvkd6VY2e6jBWqUg6E9Ox/QHhv4BK7LxkC9189Kxaw6YCDEHaghUeJekAzr
         opq6oDWpFkGgg/5frIlv22P+vL3nyhD0UGwDlsASfgpg/xKFU4oo3N+aaljxDKg0ES9g
         DVTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769518591; x=1770123391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        b=bYpoprn9zPYFJvVEouZndT3wiWPW6VgdJdpQhnEW9kDYzUXXX+Ux2rNPYUYcMdj5/3
         PFnS5LEpqhRxbudQVO2QIgoO217+gURozLf84x2WDYxO1l+f8qGRTH5541cfgoTxSjMv
         kK7jVz8w8aPMEsx9ETGIsuI3R1pOXE4E3YVgi6odpTysufpgls8bu3kxUAcWh14XaBas
         MpBNe0JbrimZLasMc3snwNdNnWmYi9WIvoD0d2qnwn4vLseZsA9qREvfLzrTG6rBeOui
         0P8gpHCRy+1wYzmpsrkpSFJXng3Ncr+S7VxsNrHb3em9T+N2JxEgB3H/NHjq/Eg4d0fR
         SI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518591; x=1770123391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        b=EW5g5RqG94apD0AnjCdY2KJVr5v6Qve+wr4Taw1X3uARWoXZ1nMFImzK8IiY/RgCVT
         cdyJJwJvCharcdEQJceO/ZUhCEu/rpZQkYXlgqG3UXml+dUA02OT1YTCaQVpY+V0cSES
         B3v6jIrzZ8RO4YhUAl4MC4O7XdpdvI4dvxRLr4HXE6cLu4WnUokY0vB+dPoKusQ4jV1/
         KhCZBlvwmLepw2T37+Ye+yKkL0rERQLbEuvUjv6qeuSia0Lhc9/CdhROxU9VP99e+e8P
         3PTybx3M2JKVeOB2n8+SkFSXpV4apflMM4LpcvyYwfH9QE4xtHQYXv1szFezjX7kX2GR
         afAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGwvDx875toFchZMvyH9N1Ht1OCmMflg4CuCKbyvXLyNkK9XU3NxwNDK5D0FsshMcKzpoWc0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5qXbNgjB8+iD4P1z/T1/o/UY3DnMWW3rJichNZ62gH/BOdWxp
	51eneMWCOFXmw3MkDDzlEnjekV8ObCMV57AbC7u7sCV8OZ8R7PHqo7JEid3QB+wmuyR2+/hX7ga
	89Gm6FwdloOga4HuM3iSUqZBmoEYXgIy79Yz+Kx9U
X-Gm-Gg: AZuq6aIzD0mKmDy1hFL682MRVj1rfNVEMDFQ8vZD68FGjekjLKBqWXLhJfMqmlM8uWb
	qwMrXezHbHTticI45Hj3pP5qqyhzt2pveWGKhzOAEr5anNsWkvBy2dqlKOWRZLfXslVfjVU9w2Y
	3nPdUgvZWAqev5S+wkMdviCDWtJ9dP6Pbzz0U3I/Gz5MjpTXqztwam9OQitl9wtZKBQGE2HYkBi
	EU0f22ghmSTgPEFQUoNqbDMcEPDOABe/lQ1DN95ZSsB7DGwfIi4Y9xO8bR2fqAbUpRPAhI=
X-Received: by 2002:a05:622a:95:b0:501:1813:4165 with SMTP id
 d75a77b69052e-5032fb1e136mr18371991cf.70.1769518590674; Tue, 27 Jan 2026
 04:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
In-Reply-To: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 13:56:19 +0100
X-Gm-Features: AZwV_Qj2KzUhSRnQshlLMp6CWqqzx7W1z7GHrToYMhWl_sOMG8tn60ohHqZx0Lo
Message-ID: <CANn89i+OEP2xxNjExxxE81uT-U+nZSSFLT37gKk+25CpU6ZEsg@mail.gmail.com>
Subject: Re: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum handling
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253858-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91DE69493F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:38=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> mlx5e_psp_handle_tx_skb() assumes skbs are ipv6 when doing a partial
> TCP checksum with tso. Make correctly mlx5e_psp_handle_tx_skb() handle
> ipv4 packets.
>
> Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

