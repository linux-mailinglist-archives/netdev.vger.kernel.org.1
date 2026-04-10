Return-Path: <netdev+bounces-277268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCqGGc6Z2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622923D2D06
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BB7E300B8ED
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0335F386575;
	Fri, 10 Apr 2026 06:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FheR/kIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170437A4BC
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802824; cv=pass; b=fOyX9gHHj1uDfLV0PP/d8/sdUq5JI63gxIpXTMwtdNj1QDHLWL+Tohb8zt1vj5YfeXSFaYLVFLveO/tSQTeTB8YpHCrLffxThsD9M2OabDVxSsbJJBzfM9SymV3lAkbdXWSEnG94BvEhgk4g7ndTNBVWFzy6MAwJgJN3fg2R6c4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802824; c=relaxed/simple;
	bh=+eMA8St/KaE5nhFAtGv0hj0vtG/KMVkRHJ30gMSjV7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwosIe1AER5AtAL202Y1MKAvi5WI5UJh3JtQgOdrABzh49N07pRWScaYUQO84TIr65MesFN8YXvbBQEeD8BHsugo7mw4Ckpn32Y5n1zi8D5wmjxjhP2iTvQEWgkIKC2E/VMrSJ2AsWLXaREbTagpzaVlE8P/aXGzZg5BcSI4INM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FheR/kIM; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-126ea4b77adso9772943c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775802823; cv=none;
        d=google.com; s=arc-20240605;
        b=eBBCUF56s82ikFu7hGwVn1c2XtFVwqCvONe2fmISdDxvkR9caFaph7Ba+2I3tbpocj
         gqFAnQFIGW3t5Yw2s32BNKr2Hth5Kmx6td3XF7RMS9yWHDnSc657zYRuxT2oo6aOf2UN
         rH9trC7yrk07vI1tVm5NyjDDR+mo2oTjGJq/DsFSGvzRRZ8Xtpqb75NJOE32efUF5qKH
         bK2CSbB0zO/RkUX4Vn+uiVp/z4ZYPpB/pF2ip0Bjxq5BkVsRavaZopawneicPbUxcx4A
         uPxkju4C3SCnTe2HFLLLU1FwLgkpG/wJG1dKH4HHl0sHvQ4vQIcoqtkbVGj42W2Cpldm
         /6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+eMA8St/KaE5nhFAtGv0hj0vtG/KMVkRHJ30gMSjV7c=;
        fh=F0VyUVGf0UtW128joX3YzwJoVKGPf5f/M+lDeRjY5Ak=;
        b=DYLBWqF0k+wU9bMHlWdvzeDsiEI96tmJUfYUOTBb1t0l2h8ze5BSNLjtGovkrd4VBQ
         AY9o3QxePLf1m9zFT7VhnrmI6amfLmh/NtRWPdGw5wcsE4fZkAbE28hDFxnqLIQa+l70
         gy4Hgf7GWYp0TU8+nBJD5pHEiz91VstQ/opcjFsjDBPdWtGZHg7JBckFUNQumZRDSoIx
         1Hpa0ccsrkk4KgADZjPFaSzJKE/QpAgPuWDAbQ/aHXsC715uzF9MTQwe9rx4zQcBxD3z
         ClznoDFfVlw8lteehvrcSSGwjmLeXBI63WjeY4Ukgf43btjfntMCfUlR3EZzoqiYYTbO
         BI6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775802823; x=1776407623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eMA8St/KaE5nhFAtGv0hj0vtG/KMVkRHJ30gMSjV7c=;
        b=FheR/kIMoTH+ExRglsdqhiqC1TFbkWjjRcr2eWQ90UOURVEh4zzaehOPjw13H1ZPgt
         csJIR7EO7evXD6UkxE8d33sD/mMCMCsGM1wMpKGcFqDNyz3iSUdi8qd3cyc0ZVQ5EToD
         nzB52wgc4CPaizNC54Z3SVNH5SEl1EJvf59d5sz3jO9pTLj6ofGAv7bYV/SoBCdkAKYh
         TNoIU0oX3GYa3eqdwvi/tKCZNqBer3BtNAki0dQ1/WdOKzRJe9v4WDOUL9GB+SimOQ7g
         oRt/JpgIe/IYr4F3HWO+rSVsJPhL4zkf6cUH/nJcn9EggNEZndL6WE74hjWsrd7V+jrY
         SAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775802823; x=1776407623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eMA8St/KaE5nhFAtGv0hj0vtG/KMVkRHJ30gMSjV7c=;
        b=GdQ020sBunbauH4PgKo+qeO6UqfTjm2yWiLPaXz7U2yjbZ/tkmMQsKBEmeHLFA8Yn2
         GS+gdJynMxcZq3IelYV07xsClNDVvtYZb0o/CbegF9NtqZbJkxxX0TVA69wGjnh0QJD+
         Qo9VjHS/pC5pqZB+k8lMirBU3Ad3tuaQ39qiYOYhsZrU0uJbey5Sa+aXFoQXesRI9QOn
         umZhffO4nXEaTH04585p1h6MBjJViElwpt7mn73JpZkfpFJX5fHDjKIovF1PvHfFcSBi
         RM774aBSjAii99GGw04ess0QKvB4czEuV3RBHbmuiau1T7YZZAP+Rdu5l82BJV7Gmiol
         7gKg==
X-Forwarded-Encrypted: i=1; AJvYcCVw0ZTl42//YZN+chMHrAmaoEOTAGERjYnFNEZ/GOeDgggzDzPuyTBNhU0eAFbahEaSuWM6DgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0aHXMfDALa3JL4UF0EUvnFhA22zCUxMyZGZpYywpSrlmorD6
	Ksjs/TfI6ekrt9Gw7bM0B1mC/jGGmNrLwdAs62RQD2MooojVs/np6mCo1crPdRozPCQvMBFrmkw
	ongbx+65D6GFixOTUrJuEzjdr5YLNHh4OZ275Fqxf
X-Gm-Gg: AeBDievp3tJ7eBY1SpamEzAeUKnJ0EueCOXzRKWFOEZWNAg51mxwKvl6rdpeUDKC6GP
	IOSkSoFUZhtTNA5P3rRZIkEBjpUNEF+gnTGuDcz/9ahlJuXAqn/UdUFATSpX34JMehIdflaRhZM
	CKz7rJujIJ1byfI6+ubqKhbGAxvRIWSV+B7wO7dL8obvoXsHldEB8aQ0Y3bpYNI722mA3tK1DB5
	+WI8jClvvXIqKnaL4aJRJKzihIhFedjTLuTZb+OK/PXcxDUTLvdGKnuWMV2h9fem5HS3E2bTF5b
	oOzq3qt7X2ZEfaZiQO6+2XIrWc47nra0QoFACg+9kD7W5iwGUj8WR07gPQh43VsufbSywpKuca6
	2sNypeFw=
X-Received: by 2002:a05:7022:23a2:b0:128:cc34:35fc with SMTP id
 a92af1059eb24-12c34ea5acfmr1232751c88.16.1775802822276; Thu, 09 Apr 2026
 23:33:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-8-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-8-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:33:29 -0700
X-Gm-Features: AQROBzASXHaWSXdNwjuGGPzAUgyVMWGp4TJ77-CX_MDIH4j4gv4uMo7rYS_xeA4
Message-ID: <CAAVpQUDD_+yprfOX26xshF337ZTvUELeB55rUvZS6J08S6D4Yg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/10] net: team: Add new rx_enabled team port option
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277268-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 622923D2D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> Allow independent control over rx enablement via the rx_enabled option
> without affecting tx enablement. This affects the normal enabled
> option since a port is only considered enabled if both tx and rx are
> enabled.
>
> If this option is not used, then the enabled option will continue to
> behave exactly as it did before.
>
> Tested in a follow-up patch with a new selftest.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

