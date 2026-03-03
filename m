Return-Path: <netdev+bounces-263405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGDKKuU/p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:09:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ACB1F69DE
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63AA4302A53E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 20:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CB1396578;
	Tue,  3 Mar 2026 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDlJHjnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CC0374E71
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772568395; cv=pass; b=U3paqD/0FchL7DiP9Lb83a9cOpvcZ2LnNS4FIclHlOi7vn3ASSnBoJ2EJZ9jqaiP9okXdkEvuD2gRpRM0iQac2d+3/GYxaGR6O0zWsUslCG/xz5UfaYasZ2oVGcNpEz2VuuiQCdGYdMfxXR1MdBoZ327akLQuh9azoPlLRrl+78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772568395; c=relaxed/simple;
	bh=MepJWrds6D6KogMfIoKmi4vRugYnGwSLfLEzp7mm5Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6jFMEhBtP8dw0iOAhH93uNetXOyUtBm0NheJI5FxMkhmoawEHxJK9G0FHY/vpnDTrRdWgaZIJ6WsZuOnMjaM1I1ZW9Ryuq7RUgKnH/so0pn6MzTY6pB5TLteTjDvuzRVW5nYmf8SXzMgaiPA3adniavBIrqU/xrW7IrA7iLo6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDlJHjnR; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1275750cfc7so931753c88.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 12:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772568393; cv=none;
        d=google.com; s=arc-20240605;
        b=WssgLIgP7vWwJngyO87AFeXI1HrKL1BZSMzwl/mwsWBHu1TLu3BAbRNWcX96kUe3T2
         qCOzFA6XYPojAAcmeqz9Xsp1tqGOo7YeVcP8Qq7qtybBSZUINCwa9WUcsyNKkRROcxGP
         DcowPgawWxdnNRetsjGDKTGD37Ts/tDWBXSOSx5lSL3CCKcupwUwEDE8Z3EK+8vA27Ao
         wgHAwMbHAGCJ3//hW7otHOs3+lNw3rp6E5hGmVVisX3ei/bd2wGbmVIP/Qfzz07rpUXw
         ARsbc7ogwtbdT/X/rxyskBjZXwkUIki2cOPC49su63wVm/0OWgXz9n7o5lWSe9RMmTOu
         tMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MepJWrds6D6KogMfIoKmi4vRugYnGwSLfLEzp7mm5Go=;
        fh=SZ9NTkpG3s/UT6t3VH4j+xAVJFRko7jArZ9vIrUgAMU=;
        b=Bc3CwCjK/c3mLnXUyO9lIiHBIZ03JTDaOJGzVbzBLcdyJn9E3ZdIN5rJRbhCfoepRH
         fJJP0/5d3qHqRfpDL8v0E4e4LfcSwNGroU8stYIcHiBgvCa3T0GJ98xvf+oV/VHsLLw3
         2TbcxzxLAS03SmooVirHI7Eo1WOhWiIU6Urd19Z61v4bddTl4r0zMIuM/bZC6ZMmSokp
         epLMRj1tf1VxPuxGZ5tGd6gGZ3JU6MwvNNiWYp5Ud8CpnL68NZYYYwcciz9R8f1hvGFp
         ch3NDpZkLtaiftze4tDCSINny0GsaKX/XHmLpDlvSolSyPVynvXcwcveNFg/OGKIRK/Y
         NTcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772568393; x=1773173193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MepJWrds6D6KogMfIoKmi4vRugYnGwSLfLEzp7mm5Go=;
        b=fDlJHjnRomcDBhpBJ44jLXe4bZGKvPF2m6I5xQ+Q+B6A3yEA3mAnxwDuvn/8Z/FPvW
         Hqu9aCDTKKIe0wWxKNxsjJNblz3PNFB/PQJTTYYI3URjMgBym8yPZnyuc9zIzxkIQtEB
         rwvq4g4SY9qXLU8n1VBKa8S71VrOmf4GhHClAYIx+d0zf7uqAKSZMEuVUf0t/nqkjBXL
         uURM8751A7tWphorS/Nh7kNM6e2c2cgFAnPowApbNCIhC7epFWAobtKXliDXH91WpZss
         UioCUtIqZ6bhUcACUUy9z+HHP74h80dz3yor+kafG5JO+1P42rKOhxhSTzE0KYMJToxU
         P8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772568393; x=1773173193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MepJWrds6D6KogMfIoKmi4vRugYnGwSLfLEzp7mm5Go=;
        b=TV/OL3whCKlWgdF19ovGFGraP3ZZDRfiD+WZMqrFcTsUTjzsZD4xT1bkMURDKOwjAM
         pkBFvrj79TB7pUN7ItOHKx9z9jyasS6jqRV8GabtBxYVgYfDK74VjqgJ1Pemp3xaJG5P
         7r6kEOQTLhJW6gsZz6Quxbgs4c+sr/J3a4z2vE7HpfdeN1YH0GhYNNgmJ0MVy/6jufQT
         Kxx3/1n1C2lYhXKVCiEUCKeC/OhprmpqnorxUjJKcmXoQQL05v6Ir4aGH6AJ1DzRkyRG
         ty42ce4egiARmOuBaUQLXesWEbBL5EQkziv+HFpQc81xYJpgM6zQuFEdyN/ih2A/59Mm
         tAAA==
X-Forwarded-Encrypted: i=1; AJvYcCV6STSL42Pdpk2zCVs3gd6OHYL7ilgjNhhGfUdfi8FDx7QAiDT4CEmAPmwnqRPUiH3BZAe2oUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyXevhSfEau0oAej+vLhnnCaQFl+4tUv3Aw8871mV3oLbREpWj
	DilhLq4iDgyZH4bMqK63XOrbgAVFD7p8lZO9wqKya2zaLCDhvQaYFmnRzlJuiHRN6muwFQMWMyw
	9jAcTxx5akjIbkXtXVQ5VBYlGkiPIog/2QuCsCasv
X-Gm-Gg: ATEYQzxwrjaNJo4BubP7v3RJ2+udC3aVez1KTJ/lOWLOzLUm8h4TGFaB+QJHvGBDatG
	8VmLH78UFPsQIjBxRY27tGuRFP2uQPxIgBirsxKUxjs/eZzNsMh5n7nhG0noqhapeGdbtVFum6k
	oOGmkIzRkzR8T0F+K07ctHKcb9KFempKt9ObnZJrla4c3KtLmnqQ+1BiYhGXt43mvlum9JhxY2r
	/2YuQychRnXhfBPJNCAjglP+Bde14eF1cUqtP71YWpIlpqRKkG4v/QjcaGNx6FYDxGM1je6Mhwe
	VF96S29JeQXGaJ4aQH/m4wVhUvmtNcZ6ZfG6vt6WIUCUvkuEc6yVFDVZHiakOKviOg7KJw==
X-Received: by 2002:a05:7022:486:b0:119:e56b:c74b with SMTP id
 a92af1059eb24-1278fc629d1mr7581389c88.16.1772568392671; Tue, 03 Mar 2026
 12:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com> <20260302181432.1836150-8-edumazet@google.com>
In-Reply-To: <20260302181432.1836150-8-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Mar 2026 12:06:21 -0800
X-Gm-Features: AaiRm523evKJuQXJj2EXlC132pYdsdJ0hXao6bYdDcVv5XQIh5pfGiNXY43vXHE
Message-ID: <CAAVpQUA4c_iZ6iAX2tzdpLJf+UP19j-h-2sY448M3u2kMXSoLw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 7/7] net-sysfs: use rps_tag_ptr and remove
 metadata from rps_dev_flow_table
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 25ACB1F69DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263405-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:14=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Instead of storing the @log at the beginning of rps_dev_flow_table
> use 5 low order bits of the rps_tag_ptr to store the log of the size.
>
> This removes a potential cache line miss (for light traffic).
>
> This allows us to switch to one high-order allocation instead of vmalloc(=
)
> when CONFIG_RFS_ACCEL is not set.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I like this idea :)

I wondered if the alignment could be by 4 bytes on 32-bit kernel
and I learned it's not thanks to long long ARCH_KMALLOC_MINALIGN.

Thanks !

