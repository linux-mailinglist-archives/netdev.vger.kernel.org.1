Return-Path: <netdev+bounces-258788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJHEFusckmlwrAEAu9opvQ
	(envelope-from <netdev+bounces-258788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:22:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C113F82C
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619933007C83
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996B52309B9;
	Sun, 15 Feb 2026 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWc3joUS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABF1991CB
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771183336; cv=none; b=Oofd0pqpXwD9rN0QjFx9qiiNHul82nKc/nbGwsQKoJbIIS3ZG8chsbvEc/ZCoTWjlpcCgJ6dpknp/A4usJBaLeCJ/zy1EOPmU6ywW68J3b+4t2af1/Kp/kVcErm/jf/n/V2cHGvLKoX0pVJQrdDR8nYahQ3P4nIbxCMukxpTkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771183336; c=relaxed/simple;
	bh=rPIaYVvi/NhaRLJdyluxXKQmCXnhOwFnZrZdjVPXSHo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jTVtaZ/1CbnCiThHb41nI6M48IH1jYs5ni74262p/6OHHH+mNffbrwUt1URYxAB/JDn/oAccj+Clwal2Y0Dg4JKXlxQt/ICSegD4F5x7YEHocZErAmdsjOfNLl/ifpq4j4MuEN59ZdMZYTrwXdxDjjjKjJjeolDe2kT8RC+s/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWc3joUS; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89577f866d6so33932946d6.0
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771183334; x=1771788134; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi15ShqOTIuUPpfpFCRX8OP6IwOyBKheQ25AkLpKxYg=;
        b=iWc3joUS81MLBUQT7bohJawKMN67hv3CZUl7uHGkPY8ZjsSmH/sJOAkrfHlB7GpWQF
         wvj//z5RBkphd0942u4Xntx8rsiCi8drCIHfqc85kCne0ueMX2TbwGqw2FnoeTPlogFx
         vlSw7HlKHuUxkpxsDfsKJCl6LnI2Ln4dGTUlmH9fBncDLu/iB+RticoQ2VI11VhJoab9
         gLlLm8Vp3Od7+7VVLqd6zzJXop1UA2ykv61e8MDTIE74uqyI+ZGPKaxAY56MmLUATdAC
         0dtgUQbGUd4H2XpZMHjULpIhFv2JSgu160yXm+CgjkDW1wpgTHM7NoLa9Pi7IZ7kwyGw
         XBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771183334; x=1771788134;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bi15ShqOTIuUPpfpFCRX8OP6IwOyBKheQ25AkLpKxYg=;
        b=pN36V0FhaeBrMHv7YKz0hNKphNHMB/CVixEnP2qfRsOnuxrSlSeg6TpUEDkY6sdrvL
         Z78mbiXyfTg7HEahz6L0CqdeFGm38o2CqWTBhs0UlB7M1dKvTHzKlEOHsDQKnxOcLvaZ
         i+YN7Rd22umXabRUW5K+Pcg0nIp0M9qAeOB/vBdQrhGgJ7YCXTWThNzsJw/oKS0PNaJm
         MQvK1pZY+87PYOJ75v9hnG2AzBWuSOP41qD7ahRreE9mhwnTQukJl4ZcE2m1NsM434bg
         Vnu+P5NqD5ejNbAn383nYmj/Rs0b8cOIa+LnRgWBiaiHRy+gFGudfCjVh2L7LzRJzfCO
         e85A==
X-Gm-Message-State: AOJu0YzJ+9D+lQwEZ/uuvqIYABvDH7jPWvC8i7gglMU93sqiWCW3xQTL
	vzcR66zlfkx5FTJgQPr/VNGVeDFC7j94iT5jjBLjsElfhGwMdNuiy3ap
X-Gm-Gg: AZuq6aLd7dy2+2OVQPBHdHHFgTa1pqOue33K27O9BNfBczzwqCDJAj1AcKeWtqEcLyV
	+gJHp0qnqdVIoR5KgIEacCqJCg4jOVS6wvGgYbuqq0l6qxpTNKdvuvZ1q94vLTjM+8YAIe00U/z
	nOhmxae9N3vacZKj2wyYgKgabrzuDf4ziNMn6v5OfsyR6YWfb2sO0fvl2Hznk44mEr1iefVNQl3
	exk8MWZWGyqguqN969TAw3DWa2Yz1sjeuQA7Te+SDFIJ1660z4a5JOyB6vdC38PvMQWWdIO+pHJ
	R4GnlsG1OzIlSkoJ4S+LXdAmBz2hD9S9TduvBi96mwoThNOZ9M/xICIc4u3Nd9kK1CScys865wD
	Nr8V6ZCh94kPmqNzsQ5IZnDTJs2n1WFDPcGbJbJDA385ujBW665faI73RP8/V/+TpfRK34S1wuJ
	9U6wMYfb2JiRAjxZlksXJu9ZsFjOKYJlaaDxiNJWWvZg2LAkC3N+M7OYiAlcno70eN
X-Received: by 2002:ad4:5d45:0:b0:896:f589:cd7 with SMTP id 6a1803df08f44-8973f276ee5mr93788006d6.6.1771183334344;
        Sun, 15 Feb 2026 11:22:14 -0800 (PST)
Received: from smtpclient.apple ([2601:985:4601:5df0:1939:c7b0:bc30:a1f7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc95acasm117675646d6.18.2026.02.15.11.22.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Feb 2026 11:22:14 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX
 path
From: Shuangpeng <shuangpeng.kernel@gmail.com>
In-Reply-To: <20260215085510.3081-1-hdanton@sina.com>
Date: Sun, 15 Feb 2026 14:22:02 -0500
Cc: netdev@vger.kernel.org,
 edumazet@google.com,
 linux-kernel@vger.kernel.org,
 Jiayuan Chen <jiayuan.chen@shopee.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2CCEDE30-6BDF-4815-9975-40EF6C982520@gmail.com>
References: <20260215085510.3081-1-hdanton@sina.com>
To: Hillf Danton <hdanton@sina.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258788-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A76C113F82C
X-Rspamd-Action: no action


> On Feb 15, 2026, at 03:55, Hillf Danton <hdanton@sina.com> wrote:
>=20
> On Sat, 14 Feb 2026 21:51:41 -0500 Shuangpeng Bai wrote:
>> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
>> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
>> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
>> ldisc_close()").
>>=20
>> That commit moved tty_kref_put() to ser_release(). There is still a =
race
>> because the TX path may fetch ser->tty and use it while ser_release()
>> drops the last tty reference:
>>=20
>>    CPU 0 (ser_release worker)         CPU 1 (xmit)
>>    -------------------------        ------------
>>                                      caif_xmit()
>>                                      handle_tx()
>>                                        tty =3D ser->tty
>>=20
>>    ser_release()
>>      tty =3D ser->tty
>>      dev_close(ser->dev)
>>      unregister_netdevice(ser->dev)
>>      debugfs_deinit(ser)
>>      tty_kref_put(tty)        // may drop the last ref
>>                     <-- race window -->
>>                                        tty->ops->write(tty, ...)  // =
UAF
>>=20
> What is unclear is -- why is the xmit callback still active after
> unregister_netdevice().

In my understanding, no new ndo_start_xmit should begin after
unregister_netdevice() has completed, but an in-flight TX still needs
proper synchronization with teardown.

Concretely, CPU1 enters the TX path (ndo_start_xmit -> caif_xmit ->
handle_tx) and reads ser->tty to use it. Before CPU1 actually uses the
tty, CPU0 drops the last tty kref during teardown, so the tty may get
freed. CPU1 then continues and dereferences the stale tty in
tty_write_room() / tty->ops->write(), triggering the UAF.

The KASAN stack trace is in the report:
https://groups.google.com/g/syzkaller/c/usNe0oKtoXw/m/x8qUc3yUAQAJ

Please let me know if I=E2=80=99m missing anything.

Best,
Shuangpeng=

