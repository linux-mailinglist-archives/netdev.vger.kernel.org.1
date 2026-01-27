Return-Path: <netdev+bounces-253708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7nP+JT5PeGmSpQEAu9opvQ
	(envelope-from <netdev+bounces-253708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EF90219
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 06:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C70EF301DDBF
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14B2E7165;
	Tue, 27 Jan 2026 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvd5weqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68272D0600
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 05:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769492281; cv=pass; b=VcXZNmopHG+OBBbyU9hvbr6vDdIXSEvveULg11eWQLLTZQVZ4Ph8rjJRiUWRSvabyFA07Au7NUbOV8aO+if7HejM8qNucoUNdM/IKD18mMz31t+t4W2QZnzuyqU78S3/waD9yiXnfiW039TNzyizjvs27wU7mjJ7CpxusIDwvBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769492281; c=relaxed/simple;
	bh=o3eXaOSbySJmbAV5nxMRG9XRUBCW/3eoH72E8ZR+Pnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiECweEd8/1HtwdK2ZPu/pXwI9090hbSARyWnNI0lbpOQNcx/PlXo2lHP5jiUHAXNyjwman4H0bJnWkr2iHeRcc0XzF5aFCpIq1Knh+He72TENOpbQrUnnTjeaNKLLEMl9M8K/Ga0COXV5vrPawRVk/NdlivTmmApaNr0VhVQYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvd5weqr; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88ffcb14e11so88044886d6.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 21:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769492279; cv=none;
        d=google.com; s=arc-20240605;
        b=Il2P4vhY6vez/eELQPdt6tW2C+Dpu+N8satVhrqS0WBGVDAdPvp0vC41l6s/UFLL0e
         7XrCUjf3PUCFuGqCHG9rFZORi3/TpMvV622cMW5gFNzRQivA8XgGF5n8o4cszMrVbnSp
         hOV7FFq2yNXiHQax1ie0qZ9gAL08bhc6pgmHPgg/2YyekZohY94Eiab5+WdqNU0mZhqZ
         3WtgGScN7YjF8NjrhgC6D8v3KDkswElTbZ+CaQOboIQI7V7xVdewrO0H37vNPmYpqjrk
         dffwP8SBXmM8bWwF1p2UlOP0fISJhhNHjPnKGXMNl3LJymL8ss52Co5S0DGS4QNlrdBa
         RhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o3eXaOSbySJmbAV5nxMRG9XRUBCW/3eoH72E8ZR+Pnw=;
        fh=ZVhBM/oikJs0VqrvYcBRkQQrDWLq7yF0BnsqOBQZAjQ=;
        b=Hbl59Ko/j4voiQmbKJCXguOXrqgvjnC69O+/3Hth4XIPJRwHegYSvt44v1AxvKSD5c
         8v5vLl0ZcKrXHSrTiZ9pkZQGD2ZolGrDZMANmoeJKrYqn+Iddteq7K+8rqN8tYK8AUgy
         fgAKNedcYzShlke2uevsTVZzg/B1rDA8wFXx6J3WhURmYOcG1VDtz13jv+BK7+z7mx4G
         PwGRR25nLGrq1YHSmw6aRDlvY9g5m1Iqwo8w1YqXjGCWkHAYpSV+t+lrQpv+oPFWLF8T
         YVLt4aKmuSUgXZpU6U+ueO81IaG2oXQropYxM1gosH+kzc2s/cY0jjjGQvRn6lomtoXb
         1QFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769492279; x=1770097079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3eXaOSbySJmbAV5nxMRG9XRUBCW/3eoH72E8ZR+Pnw=;
        b=hvd5weqrfg0L6OyON7oX+IuOm8D3XVqJ2oot+wsnMJoWDcCSRQIkgz3gHisGbEPWQj
         CKTzaQIlidAt5nttH1adjk7/Qc1mop7HmO2ovMqIraEQjWe/CRdVdIPTbU66XX1yVsv6
         FgC8SQRynmNzw7CEOSmi5GH/a1xrRXkp6T/GsW0EjEWS0cdSTbfPTMitslKehtMnulYE
         TjPWQDw2ZIZmaZuUpr5HOl21XJPsULlF2sxdM5WJjj0tvXj8ukTwmnWErRhGjbTPmgDG
         Ajk14YCsBOBWgYwRXa3pZhGn7eMYUBMEvRl5x3O7un9fl3gO7Glq8qm6nJc0fw/Cg128
         eZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769492279; x=1770097079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3eXaOSbySJmbAV5nxMRG9XRUBCW/3eoH72E8ZR+Pnw=;
        b=k9L21ghSUeSWHFHaO1grRNi8nm9IdVi/jt9NuYw7cGSQvtTiGEbDtyGBjt1MoTphWR
         yHW10befNaMmLFv5P//NHPkIMv8L6aZRH/0FTUJkueBUB+MsUPQ2GPdqLuhLYSCayN2s
         JLJmLdiPHyxWYP15Z5Adf/1x9Rl7AXmxVM4TugQmDSpR/aRCayz6mvlJvxo1ooyY7zi0
         Y5mPInzoNEW0AjimeyrBmZ9wHYIo3WKDfSRgCiLRs30/4/VHdBIEoVMHsD1w9RmD0TSR
         fCWWVMmOwltB+5C7mdgf6Ec9e8BvFWbxZGoFN0VmXOLkoRWjkiXDUSSN/ESi/sH/ky6b
         V3gA==
X-Gm-Message-State: AOJu0YwODUgDtexTthmngZMR7Wz3tk9n12NmFtrN1e1nbUKQouycO3CZ
	a9v6Bj+XCZviPd23nUEVbfRYbZ279mhQh6tt7EJd8LGtqkxXC2a6ttpIqgmbP6vzb5F8t3rRgxV
	PJlesKbxuEbSMchTIdyOuDQfcHpZhZe0=
X-Gm-Gg: AZuq6aL6gqg46c4Bwu/Ny2F+z30Buhlnf0UWZF+ReQKl11/E1ECDoBo62p41JkeUFTv
	F6has8o5nvG/r9Akek+EMcJkQuGd9v8EoAMljtXu+z7lIgMZX4RwbdrIZ6027ZEdZT61xHjKXib
	cBIPKiPs93RmVMe4iEIxpoqrnAQu77W9ozipXtZlBEFwx7vkkVuGojqNCGqV73wpxK/MazZBSap
	7N4t3c8LQYKZW25SvtVSgslbUGv9fp6G0i3wEQR80rP3h4DxvqDmyjJglvSCGYZ6EzWMsqy35mo
	Afscs1W6J4dhi1aNXqtSn9AtCVotgQebAkltT0DzX5v4ecsKd0qWTLZ7LnKi
X-Received: by 2002:a05:6214:300a:b0:894:610c:3a22 with SMTP id
 6a1803df08f44-894cc7f8904mr9554536d6.20.1769492278740; Mon, 26 Jan 2026
 21:37:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123065842.53669-1-enelsonmoore@gmail.com> <aXdvRs1hAC5E4Dex@horms.kernel.org>
In-Reply-To: <aXdvRs1hAC5E4Dex@horms.kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 26 Jan 2026 21:37:48 -0800
X-Gm-Features: AZwV_QiVjplkzIhsvBAbS2wLzjFNbC-xq9wp1W6pNPwI1DXHDpZsOx3F3uU6yEk
Message-ID: <CADkSEUiuANFNO9-A_wp8h255o-+MO6yGTy8iWt+25p0zXLyHxw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253708-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0B3EF90219
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:42=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
> I would slightly lean towards splitting this patch up,
> say one for the multicast changes and removal of related #defines,
> and another for the remainder of the #define clean-up.
>
> But that notwithstanding this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi, Simon,

Thanks for your feedback.
Would it be appropriate for me to reuse your Reviewed-by tag for my
split patch? (The only other change is to use netdev_mc_empty instead
of checking if netdev_mc_count > 0.)

Ethan

