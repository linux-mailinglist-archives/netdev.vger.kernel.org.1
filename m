Return-Path: <netdev+bounces-263798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCvrF60hqGlQoQAAu9opvQ
	(envelope-from <netdev+bounces-263798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3C1FF88A
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 13:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1D353011C61
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02610396577;
	Wed,  4 Mar 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1QdB4do"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D69F37EFEE
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 12:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772626345; cv=none; b=kS2tW2nu0yQe2x84SSe5V7HdvS0NnmwNZ9F63UymGZgNfFnaQugy76E06C5t4vfb5JrTZTp7uwPUw39lCA9/0XR/hWpAzjcGzCMSYEKEpkBGRlmjIsRoePwnwmyroPRG1nlVtHMt0/7GOG161adcZhomJxiIc4e7RFM9i9WqMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772626345; c=relaxed/simple;
	bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pKjbOY9mIVma9gR15fqPKO8fuO0HuTYrB0nEhfCln5wmpLKVvK+bP8wK/I/yVfiyik7qDwQ3YXpKbmlBDSAMJUs2Q1mXQa7/RgCy+AtluqiEvzXIDdijTZcxxor8PUmZQW52d6XSaepi3I6+MOh2cvr42mM1lbvN9Xdv0FvqrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1QdB4do; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371bb515eso101553085e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 04:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772626343; x=1773231143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
        b=g1QdB4do0A00IJyh4YOenmWRPZje1sfomIaSWdoO5KTRgO5tXJt+8mlCMh4NOULI3l
         rajd1URAhDYtIrrmC7Dl/9yuzzy8LzEsml4ruLw7DdnS09rB16NeTdd7e17rNUvZwSC9
         y+RCBni71L2aJUjNqpgSclEzrHB+j8xSMBMGs5fNrBqZPMsOo146NKaZo6xVXlNICYlb
         g2AeNcNca+Mrv5i8L09J//xIzssGVbgx2Z2jiMX+JshtHVijnA1IyOo5laJ4LKvYUL5U
         +z9CSoTGiJuT7cMFN7y0ehzUnNCJf7X2eg30hxprGKPIPBPU+2akv0N/0WUYrIgQfXls
         jMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772626343; x=1773231143;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5PBIpDZUoWmzMLSSr4AMFrJThU2kmJNnnlCij9fJqvY=;
        b=ZmEBNq8tXCbaUhdQ/6H9z9Ft+YaifpklbnXgCBJclypAndwEAKoBuNi7aBBT9Y5e1U
         1lj0nY6AV6IdXLy0/yz7bymjuGoz70F9fC2XtszyWga5lDxcoJ6Y7vp/hd/CETT5/jZL
         o9rHOCzEHZ+qbwyb3olnHJraYBeqGiPAk1+6fDCBUob0O3ts+JxbBi6jzpsYO6vspguq
         QA71eCQXDxTuhczKTidAfg0lxiDCHwOLizPZkRBB/FYrYl1RUu/3jVUq8c4cJ/4uNoEl
         nOlrD54OwC1ZAefzm5OTSK39BBtdfin6JwbhPkSDcWS1ZQTP56kB+MeEV7XtRbVBEu1I
         jJgw==
X-Forwarded-Encrypted: i=1; AJvYcCXrm2UWN0N85623ZaI9z87q+yH3jPETWwj4RTzDeAcl/rpZMX9fT5xxnmxkjhfoS3zysRWn8mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkIoGbdsHaL2Q8B5ttyuiPWWkE6PoCVwmMOeaPPV5yTPzUbKA
	7Q8qLU95J6Vs5H0Qc+NyAxG8swRpxFfRGRabSdiUT2U9gBmIQTpPEY6n
X-Gm-Gg: ATEYQzxXtk1lC+s6qb1gqfInDtRgrmnNQv7e6hP6PfBDTS8K6C/wQqRyX0Gjwl+vyvs
	m/9yrdss3Dnn5AyWl5Ovwp2MYk51KTyKNb5Kr6D0waLMP4WZLwJ239HriJIeUCCHrfJtwyIc//x
	zzRMnVedKVx4du7WuA8ryLTHHPb5UgOG129wzfc4eoZSzPvr1HpZKf2zhmgPdEeDc0IF3Epx9QE
	DqOpnvPaS0ECpMp76CTLNp692UrdOlOJBjiCijJ8h1Lx0/Vq4GsqRqQoXx/yk4fq72Fc+w/tS5/
	53SSNu7pT8rcrqR0K0vqFbykxg4hjEyv5Ed5/KqVAoLN92aWspiJ0sfr1G8t4BbL/oSOhN/X4Mm
	t9Ve2Q6TezI7S3NpQv/xKb/wCVP7i8WXzL2ULp75VKXOGC202HTKhZQlfSPdZatDMbmVf5WZwRi
	NWoT5Vh2fqchtaP4YZdiThStAUBA==
X-Received: by 2002:a05:600c:1f85:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-4851989f765mr30694295e9.31.1772626342560;
        Wed, 04 Mar 2026 04:12:22 -0800 (PST)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188923c2sm48580075e9.14.2026.03.04.04.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:12:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hristo Venev <hristo@venev.name>
Cc: Jakub Kicinski <kuba@kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  netdev@vger.kernel.org,  Josef Bacik <josef@toxicpanda.com>,  Jens Axboe
 <axboe@kernel.dk>,  linux-block@vger.kernel.org,  nbd@other.debian.org
Subject: Re: [PATCH] netlink: specs: add specification for NBD
In-Reply-To: <6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
Date: Wed, 18 Feb 2026 11:28:44 +0000
Message-ID: <m2fr6yl28j.fsf@gmail.com>
References: <20260215180309.2255721-3-hristo@venev.name>
	<m2o6lnlg2y.fsf@gmail.com>
	<6a1339999b091edaaa15e34aceb7961dfc61581b.camel@venev.name>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CCB3C1FF88A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[336];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263798-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,venev.name:email]
X-Rspamd-Action: no action

Hristo Venev <hristo@venev.name> writes:

> On Tue, 2026-02-17 at 12:17 +0000, Donald Hunter wrote:
>> There are yamllint errors:
>>=20
>> make -C tools/net/ynl lint
>> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
>> yamllint ../../../Documentation/netlink/specs
>> ../../../Documentation/netlink/specs/nbd.yaml
>> =C2=A0 159:81=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 line too long (1=
04 > 80 characters)=C2=A0 (line-
>> length)
>> =C2=A0 169:6=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 syntax erro=
r: expected <block end>, but found
>> '<block mapping start>' (syntax)
>> =C2=A0 170:7=C2=A0=C2=A0=C2=A0=C2=A0 error=C2=A0=C2=A0=C2=A0 wrong inden=
tation: expected 5 but found 6=C2=A0
>> (indentation)
>
> Thanks, I will fix the lint errors in v2.
>
>> > +doc: See :file:`drivers/block/nbd.c`
>>=20
>> Prefer to see a meaningful doc string here.
>
> I will add more proper documentation in v2. I couldn't find any
> existing documentation of this netlink interface, so I guess I will
> write it myself.
>
>> > +attribute-sets:
>> > +=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0 name: nbd-attrs
>> > +=C2=A0=C2=A0=C2=A0 name-prefix: nbd-attr-
>> > +=C2=A0=C2=A0=C2=A0 doc: Configuration policy attributes, used for CON=
NECT
>> > +=C2=A0=C2=A0=C2=A0 attributes:
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 type: unused
>>=20
>> No need for unspec in the attribute list, ynl codegen does the right
>> thing.
>
> For me `pyynl.ynl_gen_c --mode uapi --header` no longer generates
> `NBD_ATTR_UNSPEC` if I remove this. Is there a YNL property to specify
> the name of the zero value of the attribute set? If not, should I
> remove it anyway, changing the generated header?

Oh sorry, if your goal is 100% equivalence then I guess you need it. We
have the same in "fou" for example.

>> > +operations:
>> > +=C2=A0 enum-model: unified
>> > +=C2=A0 name-prefix: nbd-cmd-
>> > +=C2=A0 list:
>> > +=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: unspec
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 value: 0
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: NBD_CMD_UNSPEC
>
> A similar question applies here. If I remove this, `pyynl.ynl_gen_c
> --mode uapi --header` no longer generates `NBD_CMD_UNSPEC`. Is there a
> YNL property to generate it? If not, should I remove it anyway?

You'll need to keep it for equivalence.

>> > +=C2=A0=C2=A0=C2=A0 -
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: connect
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: See :file:`drivers/block/nbd.c`,
>> > :code:`nbd_genl_connect()`
>>=20
>> Prefer to see meaningful doc string (same for other ops)
>
> I guess I will have to document the four operations in v2 as well.
>
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attribute-set: nbd-attrs
>> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont-validate: [strict]
>>
>> nbd.c has strict & dump, should this be [strict, dump] ? (same for
>> other ops)
>
> The NBD operations don't have `dump`, only `do`, so adding `dump` to
> `dont-validate` does not change the output of `pyynl.ynl_gen_c --mode
> kernel --source`. Should I add it anyway?

Ah, so it's redundant in nbd.c.

Thanks,
Donald.

