Return-Path: <netdev+bounces-289238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL8+Ef68C2rBLwUAu9opvQ
	(envelope-from <netdev+bounces-289238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:29:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B62C8576130
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A80C83019126
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF624676D;
	Tue, 19 May 2026 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay9qWmEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75E2405EB
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154170; cv=pass; b=pGoS5iB5RDI8ZxVaYAQWbgbY6BeYb+dEMx9GS3eDtTC9MX47gsTg6FldVwQ6xD/dI4eQTAxDjK1iGoL0o8n9o/oB7VWGXZG6IQjrke6f8yY532qXKvvoALiZCeQeJqvz6MEfxzb+02l73QqDJ+4SMOA9l2cLlsy7CYGa2UcJVS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154170; c=relaxed/simple;
	bh=eXpMnzMhNVtPygjvkaUrQynRKmC6f+IB/a3lRPZsDRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqb5jYlIrNRHuwfpM0MPUcBPiamRP0Xc7Ye6AR2N22qtRPHj+nSviWOM5tkhGsMv0B34M5EqLzfCzy1PXsIkdjT0QAuWSmKraI6efBF5caWMzo0/0G+0xUa9mox7B+2WLGtMbdEha3T9ODhDumhtiEr007JKNF6PkT+gBPN91nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ay9qWmEG; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so29796646d6.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 18:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779154168; cv=none;
        d=google.com; s=arc-20240605;
        b=IKpJSOORj7CBEoD12Gd9l+4XTOcwAsyucexHyY2iu3ojBTsQ4NLaO0nDyBfm812R9i
         hqglLbSjEBli98f5tstBZeA+leureDF4Au/1gmqBIYcB7lNoSp5u1gz5cGHpXNi5CEMm
         jKrhy39Th+IVBthI+eK44xbgYnPF1LyFdiyWMdPASo9kJWsBexrVOf31tTbSsWFI3Clz
         nP3Fjpjr6koMWMkt5hRwIBKa+2OdQGyKRJb+2LDBsbmfFA0xU7dQBmdPL4AkVARI5vbM
         BOO51R/4HJVmmSMnpryYaQDuCCLtLPBkTGRbuJYTR5qXleEDQIw3nEwNvtWVJftHRaZW
         QpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eXpMnzMhNVtPygjvkaUrQynRKmC6f+IB/a3lRPZsDRM=;
        fh=GwuQ7veYuf77ovxzW9yr2gdJyC7kih3MdI9XgSIkITU=;
        b=EGqQwMeAfep1RulB4Di8BpMzkJHN1kStYNacEClVMkjc2s/V4zFWodnZpmrD/a/jYI
         iBvYdRoaPpdbvLAUY5o4maantirkuJniZiOEycQZYiQsXAWaMbM4EfqX1TaWf+y78zkZ
         5hUtE2ZiOeNgTdrQe6NAJeDiVzdBYl4vBYLAs7sFahO09RgiwuIggaVT3r1zapFW3wP6
         jMQnvQW3CsM26YG4cgqgweFVscCGpFJdmswmRN7K/QKQuprHP2JV7qcySr8tUzB9tg/4
         fMm7Y22hBDpyzhrdu6T73/3gjTSo6sQe3zvqJAHF36dBTvkGCRKCeSFbKZq4AKaF2azF
         Nsqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154168; x=1779758968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXpMnzMhNVtPygjvkaUrQynRKmC6f+IB/a3lRPZsDRM=;
        b=ay9qWmEGgk7yIbA5T7Uxd0ksQtSNcwYZyUrwX1LU8e6LTN33L/7CUbiynCvdu48Wqa
         T/pyDqZRgEhq+HX6j0dfYhna8sBaGmTzRuQ+Fmlm0pGIxMN93nZ/oPiAj1HL3zmlXo0I
         hEdWXnt+iSuYvyU8Eb1MVsSpQ69AVdS5rW0DuOOaWOODckYw8E9/1gBRnY4ZUVRG1K77
         aPQKQ/mM12gUmaz2B0vbS45gBQYVqSXYtjq1yq3HIxBOEqSByMinJv6DkIU6g9o+WyD7
         RcSdN3SZm8/oKfuaZi0BzumRwaXmZznq4f6hT5jf96hxlSwbtUImhOF1B3ZQn5B6bWkR
         fM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154168; x=1779758968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eXpMnzMhNVtPygjvkaUrQynRKmC6f+IB/a3lRPZsDRM=;
        b=bX68aH5q31eC1NIHJkScX8nGxfkZpUHV8/JPevlJjXaVWvglurx6d2Z++F082+zpt7
         Nk+iZ54KcN3xw8oSCaddRuxgyFzSLPA83fVl49xMAHg6y7m0nbDlUrv3ZifW0IYMWtL1
         W7H93JTr1n3I7xEQCgix+ja42tZqGM/snlMCpi+Ik5xKM1GfGd691++g0997SUiyfbWR
         UYRhRfrGxjX+iffOmNz8nUzvkIV3QdQ4ZSR8JZgNg+I6EeN89iNjfuunB62jugP9pvhm
         EbXYTU8gV42jd07tMYdxVS0uS7xLKoi0ZOO6LaBMLRkn00JiHppJIAiKspYj1Ntv66Lj
         Z6xA==
X-Gm-Message-State: AOJu0Yzn/wFXilln9jIC1ZzjZDj03rwTrkXinMSd14Djc7j5yqL+gng9
	uOYYvsEpTTpU3H9enIqC1lyjOLZBqgkVKDpsUetjOTtnBRR9KayO4nY069W/EoZcv/ofmB5efOS
	riLbdbV6X2tGCF7QYUf3s7RcleqaUwcY=
X-Gm-Gg: Acq92OEZLY9pGQ2qmRAOaZQyx5OTHIcKUQvhoxF0gIeu+M8UXd5Z7P5R3znwLLJw+y3
	0gUP/wAJuLWqYmQiubSTVv8Vasn3c1+gerdr9xo1na0xOqg0Bn0IVvcsY3IAy3ZlULkfY61H+Ls
	mZZxAIfCK9n0vYxk0MWuDFixdgLhg9YW0yyYXovQfPyUgwfn0BQrzyvZJJmb/ETfeqd2l9OtfXI
	KcT9DIfJ/mLCCznMFIC7ptSx6f54tByxHsklCquZtdpB4ybd/m90UF4psSJzU/oHWYr0xFr1IYK
	J6HK/OqKNCd++OdA0jfc6fgkjNazkXSFCXyr8AiU75G/TpI+y6HJbYYm8NUJu0VNNQNvI2TrKfl
	ShFE=
X-Received: by 2002:a05:6214:2d45:b0:8ca:293b:bc3c with SMTP id
 6a1803df08f44-8ca293bc68amr168781516d6.3.1779154167904; Mon, 18 May 2026
 18:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
 <20260518010739.80979-5-enelsonmoore@gmail.com> <20260518182220.78a9ae80@kernel.org>
In-Reply-To: <20260518182220.78a9ae80@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 18:29:17 -0700
X-Gm-Features: AVHnY4JGKKqYTHs8dnxVhuEHIesEz457h2IYPftY9t3TTRv4Z8xYlgHf0SAkecY
Message-ID: <CADkSEUjt3K-VQENE=vBBLAj1Wp0Yms9yACcCH-PrcBcficCT=w@mail.gmail.com>
Subject: Re: [PATCH 4/7] net: arcnet: expand unnecessary I/O abstraction macros
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Grzeschik <m.grzeschik@pengutronix.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289238-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,get-maintainer.pl:url]
X-Rspamd-Queue-Id: B62C8576130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, Jakub,

On Mon, May 18, 2026 at 6:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> This one reportedly transiently breaks the build.

Thanks for letting me know. I will look into this.

> Also the cover letter did not arrive on the ML.

Somehow it only got sent to me. I wonder if it has something to do
with my custom script to automatically use get-maintainer.pl and the
fact that the cover letter isn't a real patch. Next time I will make
sure that doesn't happen.

Ethan

