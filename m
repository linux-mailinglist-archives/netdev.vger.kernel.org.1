Return-Path: <netdev+bounces-101960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B8900C0A
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582DE1C216B8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566924204F;
	Fri,  7 Jun 2024 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UrKcVMlS"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B139FFB
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786224; cv=none; b=QHw+9jYxNKAf92L2uTkcvZQLNDGn5SZ4AxvWWs0g4xfGqbQRIT08sNmQcSKic4cx2WdMITRhSPcU1Gh5J4G1y9j8PMxoeEd18wzoSmHFcZw7iwKV2Rtu4wFJId0kKXFM6zjYN5fn8q9pqSYR5/0gNzoLFpm3RI1UBcLN5Lv+gX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786224; c=relaxed/simple;
	bh=2Xi0RYnzigepioYMasZJzBhHuea8gcSwQ38nznxB8Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYIzobrj22ZVBFCguMdbp/sbrHhk+WAXefUGOk3PoNulSHFHK2U0rBxpA5JxfmFETSE9SXrIsrsMINk3mgcf/K+QvLQHJYToCEQYgL7jbVO2ITxE/BY1HejD0aoEo4zzE4WKsvUcJEQ/hCdT4nbWus2W3eUQSPRZYY7K2WV6sHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=UrKcVMlS; arc=none smtp.client-ip=66.163.187.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717786214; bh=jjpBRxkpMLr3gtmzed0KzCkC6MUwXaUW8Hfa5XmCu8o=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UrKcVMlSfr26pw2N1absEnyk5Smty4CyiOl5E7rmORPk1XBQ4x72gnUBgrD5uX0pIgQFnFfHpfYjGG3JM/BEUJYQsXKnqJkUECnaRbhATnSpZb1zitlQQwcIuHU9QJaqr6loZCNvRhfdYNlAAodFs0GKZu0G28hH2VqQ9jnxlId+PikhKXKZX6mdOM414aBaExAohcnPJFZZoiYJL2eEsuF3fmBiMO/uo84gUb+VL9xoqR7D/c6iboK90CoRKZ4To6H8gr/QQDScCfn1DirBu5SNc5wfEH3oRTwT9LUIU4EB1tlSaDwstX2QKmuDWLATwSITGfRHekHGzV6oEIgOWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717786214; bh=dykRUqslyI0Td0onN6MwTln35FzTXIbhzNOvDrhIFFM=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sPTF+br6JcwH8zSmJq8GAGHoKGtiFhQcIQSJaiVHWmQ3JRUtlZrkP2XKrOAFAnr9+/oIpCRluLlrY9Kw0CKq/3RhlNNX2g1mY42kV5iKIWKdIH8sqA9nSxuG+rcw7jP4U49MxEcqTg50utWsyuEUcFUndlJIrNdV2Kt6BZd/2GI1WcXjuHvlhDVn6CJK3k06zcIv8jzIBjsPk+vAY0jNiDHf0+8tnqO4AMC7EVyMSQVUxKJgo22z0g6P5a96JrimpidBrrG4LoUjFQsRpv2WH1KC3YSQ+FmXvIMczG7nGVamyS3jY60VUGi0dMjQ367zYR32KY7YjAl3Xg9f9rCWlg==
X-YMail-OSG: 7xQSf.MVM1lEU0KLzg7s5h.3yRAXzEdHrrhop_4YUNh9nWE5qwgpdGQw_L4EKPL
 oKDIbZIXJ_h7cHrFICQwBwfvEzirAL8D2Y5KQShbjLhurGQvwEmY1_qpPcnLqPn8TQr7ERXHGPsx
 .La8X7eNjh4.MLbbupzLygRFfzU8cqwqmfioTvyDII683Bn.gKycDwa6JmXpfsfJ8e2Gk5a2zfqf
 DgNi8WSSS03R0pT3IrERyc6bbV0UJvGsaoTdVyPvc8YEVYjNZy9huLE3q6GZMA8b55zFZbXLhIPn
 gRe231FXw4kDFcBiUYpBY8Dh8FjVBiU0LTWouqMl301w7vcw44X4Fq8FIq9r_AGy3fGaFzr3Ex7.
 ZmrQZivSCeJPtBgiA3cNNiJ0RaFZOlPk2KjlTtqD6.LWPGlO2zSU5PpbC9VFiad9ftaqaYb_nvTy
 JXCglsZCwD_woDNMlHozJ8BCH_He25PlIsnpz0mmrz6GOXFEpPcYAzkt2gMLqGLVl.cUI6xg66W0
 6ZvwJC0BcWVuNttlC4EMYiEytAXjipMbScPs7ATZaRZM8n9YwRblHOI5hdbfsapM_Swtbkd44Zfu
 0D.5d0b4kSWm4.IiAmmvqmix3upf3FuAKNchgSjFyN79ozxDrUog9mirMlY8_ldVlWNh5M4LmTNd
 _DF2kLlGw57DmMS7oHBnD51l6ppuZ30TtE8WX_7DK5fs7ZLh2VpKylQSzPCqxS90fExclbQPWMxe
 ZtyYLk7ZiiEQd8gnfnsD5wDhozV8y_Sjmq4bUOPi.abXHXK7BJ8wf3rloMwWExQLAX9kdvCn.IWj
 WErXODWFJAjaAXtsGYhW4uQn460eAHsuj8JsIpmY.b5zhPVDgwSHH6EQRyHfzjRkASG2wGRjRydy
 A.SsuE9qu4DQTfEGcjyUn976ZuHNM4v1w38Vut.H3neaEjN7qzMNYh0A2C3ehEUbC3Ej9XyssMBi
 LTghljgVQj8dRj4RInMAVkDMkR9pkWw5ybucz3_GJ3aB9xsCe7Jfxs3r7BvG1cEIgez25zBs36ZJ
 xGc5bmQ5Qh1tBSu4EXKcv7kXPE9LscJBdMkvWqL5UqZx_H3wijcYbhe7nUu4iEZ.oYQkhW.VpDo5
 rb2A5qP1hB9I5q8CNWTGM9T0PuGNrRzCqXemvMbKjsj03P16eCLHQCqnJgYakpbdmnrGF09g0.dy
 sj2xRHJtpr7Z3_9rSaCQzED2miVvzzKC1BLWfuT.JUWUEMWx5Vx8Qqfft4ZLrpevXwoTP3h5FbUE
 1_b6.yGoxdPWKtgytoQHMuwmaza2taDTGclQ4.OW2GfRrbD02I9t72IMCbbjg4w4W3rGU40uYm8X
 WTVQJ5tnPKtGxVOkl7fpyWEqcnW20WHBSpWkotJvQhrW1jwNmiWDgomVaSsI4G7m8IR4DejZtIRu
 uQziN23gghlbUM8UkIorsTo58ofUb5i1r9rKgL7B_Kk_akwo3RsTQwv4EJ5DgdOl63Yeu6ZH0iGq
 4fXILxazHNmxYV0fqfMlJsloyqoPiy.4Z_bUS8tdEg5ZiKamHodzX.blvX.3rKX2p3xs3r9KcitS
 c4LSy5ILBu0isw9KgemukY9oq8C4gosgJdNZukXKJlrr3LWLzcv.Kh5tfPdlE9ezsFNrcBusGOqg
 p6svfyT836bJAf7ERcMRTiUyHvce10X.E04XH24fa1aW7A3B81NRlTLSJoKQFI91ccXUboxOpeRO
 lu2.Y35I4SaPzFgMuVSvsuvbZVD2P0Dc766gomc9ekQaoaBeIxwuOtYBqnmdQZOnEWgAIu5sUKbQ
 CbTtYXsHWvjmqkDadpeTge5OCpuL_TBybd_da7wSVaKMWi01.sGcOjwxtSszz_lQOlpuWsrLs.Mp
 JsYyZUhKaNxBiEmWOy5tHAXTckmgdBcly8fQBwvJHh4bS.0SGs482Umhrp660HMJpht7tyOmloiZ
 4WcYV.NzE3r5dwdiopRJri_QbyfKFNtuKzfqpeLQSESpXeFgYu9syirZoK7iCibl9QmzcAaCEyLp
 v9Z994TxHBCrKy3pz.A3dYnnGlfPHt5wyBm3cdecJhna1a.jaVsfQR2.z6reiJK9wzKDnE5h03m3
 VL_IkirE7rItekj3XMJ_7PRDiRcbh1GtDPXk0D9omC1T6HxgvLLvV56zXvZ5M8_Sk4ueBHRe6gKp
 dMEKDJLA_xPHHKMrd09Uz7OWWSAvAqSMq3nY6iGOb6XL08FZsW9ofDYjgntf2PNdjgUee7mrmGnU
 0KCQfO31UxASPV.PKveYAFjAKbod4g8JUyWEEfmtAYeLwA95MdW7O6bx9ZUaMahg2yOEBwlLZO5.
 d.mAmQfE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6fd9d693-87b7-4c08-bd52-39d2e1236bab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 7 Jun 2024 18:50:14 +0000
Received: by hermes--production-gq1-59c575df44-8lqx4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 112a64c8672692ce743352f04ced2bf3;
          Fri, 07 Jun 2024 18:50:11 +0000 (UTC)
Message-ID: <b764863b-6111-45ee-8364-66a4ca7e5d59@schaufler-ca.com>
Date: Fri, 7 Jun 2024 11:50:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove
 the CIPSO options
To: Ondrej Mosnacek <omosnace@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240607160753.1787105-1-omosnace@redhat.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/7/2024 9:07 AM, Ondrej Mosnacek wrote:
> This series aims to improve cipso_v4_skbuff_delattr() to fully
> remove the CIPSO options instead of just clearing them with NOPs.
> That is implemented in the second patch, while the first patch is
> a bugfix for cipso_v4_delopt() that the second patch depends on.
>
> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> https://src.fedoraproject.org/tests/selinux/pull-request/488

Smack also uses CIPSO. The Smack testsuite is:
https://github.com/smack-team/smack-testsuite.git

>
> Changes in v2:
> - drop the paranoid WARN_ON() usage
> - reword the description of the second patch
>
> v1: https://lore.kernel.org/linux-security-module/20240416152913.1527166-1-omosnace@redhat.com/
>
> Ondrej Mosnacek (2):
>   cipso: fix total option length computation
>   cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
>
>  net/ipv4/cipso_ipv4.c | 75 +++++++++++++++++++++++++++++++------------
>  1 file changed, 54 insertions(+), 21 deletions(-)
>

