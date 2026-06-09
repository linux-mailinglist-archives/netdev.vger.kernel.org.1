Return-Path: <netdev+bounces-297038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OyjjLt0FKGrs7QIAu9opvQ
	(envelope-from <netdev+bounces-297038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C793660036
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 14:23:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=W4PwAwCP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297038-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297038-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7824C30C59C3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95141361C;
	Tue,  9 Jun 2026 12:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E7413602
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 12:16:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007383; cv=pass; b=ZFlT/1cDLS5u92Do6CoLnaAt/9ycCAv3iRyGmoDxb7vVURtWhnukKBFcv3MzUZcMzmWmjL3QlW+Bk2NtVOSgF/YlknbbH03ioiR04MTjjy7sMc7MB19k4RN+mNJuNrvhsX4/KChYt59Ci+oY1HIIkgNqrjqIQGO2NtOCClmuRQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007383; c=relaxed/simple;
	bh=okHsnL8+kGj13ffxwZXFsn1xCZyYlTCVOYxGFJ+E5jU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sliIi0wEt0aOulfHNEjMCPonrfWiU9EPRHLDf6d9P11q39PJ0lPkTPDaGmvAADM6K5IdsvXe7ylbUl4aMXDeB9fgsTgFfIFvqlGn3lsS4u1STiAJnDlRmrHXrL19lHhTgSizdN4IXnDtuifRawe1lQ/9OfKj9QMyPLq0vYIOEyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=W4PwAwCP; arc=pass smtp.client-ip=209.85.208.169
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39677242021so53531301fa.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 05:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781007381; cv=none;
        d=google.com; s=arc-20240605;
        b=cHLAhMwPdzitNp6eo2ex0aF5r8uIZt6ngX3VTf0Fq6hl6yX1znxs79rwZKo/DGmQs8
         CnddlubxkqhyfSyFuI4YQuSuETSvD//Zw0ROylxMYjEDLWaOY7MQ+C9Qs8Q1XbU6TQHC
         1w7/KiuzOje0YPUdC/piXMRd58AzKgEPDKrBlOo0F3JflfxsJZhoj4gsY7LSJaahigTV
         A1UVKaVSarWioUvwF1qLvwY19vOd+li7RsVGDehmCilKrY6MdLxi7ahxpFWxUi4XFdZY
         ql6IV697XZ2gtoIQ8Vpyeoz8yrzAu2KXJCZ16o620hf3mooMtON9qeGZzQPeFgljirT4
         tb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=okHsnL8+kGj13ffxwZXFsn1xCZyYlTCVOYxGFJ+E5jU=;
        fh=sSobcxBF93Kt/R//1IEaTvOabSu+lKgVWatOZfLYn9A=;
        b=CEn/wsMmuPx0FnSIenxDDho3qhL1MasdGDK7VEtlq+JbkNxtnpRoi7hdXslCcZ10TE
         tND6RKdRhfYZEHSkaJCpbDAvGHHTkrMMuUyTgCuons8HbUx826mep0hFhSKnWKXohGYz
         +jCJxPtRdG6fAYBUExDrXJd83ijk6QgNJEJ9HS1wbTSihno9oJ8pTGQ2QK6HEn81u2WP
         EYHH1QEz++0zXaGeI3X0iKnWnGv+cn+M8Tn/H3m+NgtKRpRxEE4jNOWx0XaqX5AHEi75
         P1HgYzHgzKiRFbehGvi/qVTcqCViOzR5YPLxjbn2y/w1OPz5/X3WxPDsoO9ejGQSKWwG
         uonw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781007381; x=1781612181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okHsnL8+kGj13ffxwZXFsn1xCZyYlTCVOYxGFJ+E5jU=;
        b=W4PwAwCPbIQANS6y1mxauj3Ci23V08d333HMw1NRbxf5bVEnagfYk6JhwLVVFTU0TA
         GiehghNsDBNFUg+AiCLO18gScpHZ4cDJHpKZ21FcOdxzfj7+CsIWE9fwZnVWViVYQiOU
         V7M9gyf9tVhFClgsj+WhDUGbnqlCMfdhcSIllSPwZYLiCAl3FvRW/70FAQeblDoceZ3D
         G2xamLzoDvu+vUVsoB+vjog36IT6toHO9rb0LRq0Nevad3KyxQXTM3jtgMyCvOwv5Tww
         osu10zKGYL+4LgZQYCqob5X+XnxBLKRKjL2XtL6B7sMrQRThPiZS/5DwGqZFyKCGq0Is
         G/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007381; x=1781612181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okHsnL8+kGj13ffxwZXFsn1xCZyYlTCVOYxGFJ+E5jU=;
        b=ItNef4kidlLJB5M0zMjY9P0cOJfVaKy3rZPyWxIA3UIvkjXo+MSna9yT6xxj02SHiP
         5JV+ZfVfqKz3EMy/sZFlUowLuunusLvlG3XYYeM76GJYZDpGQW4OXcR4xWgLuOGent6W
         X9eAxQ0sO8KJRWO8Kf3tiknrbx2WpVRheCkQXPR4LhCfe8hUG5VJFeIeOvbSVNlBGo86
         x/YtFrTO1mAydZp9eH6k5yv79QJCU/yk5PN8f6CSyyvxfyCfV5hGV3vyl+zGe8S05VZU
         qL3kUaxGQL2Ej15R1XvaqSS1kIZ7ZdFEUMb71faS/73Sd+wttfPnsmqE2iebRbSw7aS2
         VjmQ==
X-Forwarded-Encrypted: i=1; AFNElJ92Z6WLzoDCZgBO1wr7xVDo38PLGNbvYzaQo83Z/t96I7sPP0wnT0/A6QI83Y3by/dP2p/5OcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCogZY0MjBKdeT7NAszVaC4QFEgdClbrXeZ0wLXDyyvdtZaZ1S
	idjlJOriM8vimF8u/U0lWGTWci7NMFisA6ecYnpq0d3cWNysAQitjPnbS2bOd4ID9T3cx/ApKS0
	CaMD14rVva7MuhuGxxxwz1Am2vJ8NO570Kec4Wn5GkA==
X-Gm-Gg: Acq92OEKtC/n1q8x2lwXl7BumVCETW79DRxCkpE0fczhhutWcfurbQu52NlGJLXHtdb
	xy+9fSCBRelP2yhTRa88zZWI03klSZVkOns2fhpq8kC7iF71rFLVeh8XYmppDxpayI00rKIMfhw
	C/A3VvtpOQ/n4uIClRI7P/v3hc0mffaliycp+LQhXHPBmbHCW/9wUKMRyRspT717Z5Re7GV0k5r
	uXJ8hnokm8o5tskQPfaZS6m3rbItIpnTr2Ql/OC0S9nd6bsgxUxR2HzVqtwO/6Eq+23iyjqiBK2
	H23F/O9aaCrgOo5m0BFby7ipKTs=
X-Received: by 2002:a05:6512:3e18:b0:5aa:6b8b:8c9c with SMTP id
 2adb3069b0e04-5aa87bf3751mr6215270e87.42.1781007380529; Tue, 09 Jun 2026
 05:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609000605.1234374.9ba17536ec9e.cake-rate-change-stale-flow-deficit@trailofbits.com>
 <CANn89iKOVOhJz8gPf1hJEcHTxbErVbXF0dAEfrEPjk6X+h2N1A@mail.gmail.com>
In-Reply-To: <CANn89iKOVOhJz8gPf1hJEcHTxbErVbXF0dAEfrEPjk6X+h2N1A@mail.gmail.com>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Tue, 9 Jun 2026 08:16:06 -0400
X-Gm-Features: AVVi8CexXyUcc87AwUVjcMsIXevgQnYIxFlnIj4FSx6j9GGaX9uR577Xu9GYnt4
Message-ID: <CAE+C+DZW1RTeJ6fris7h_SSjAdVhMDJTGFH9fYRfDwSOedEWGw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cake: clamp active flow deficit on rate changes
To: Eric Dumazet <edumazet@google.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297038-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C793660036

On Mon, Jun 8, 2026 at 9:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Mon, Jun 8, 2026 at 5:08=E2=80=AFPM Samuel Moelius
> <sam.moelius@trailofbits.com> wrote:
> >
> > Changing CAKE rate parameters updates the quantum used for future
> > scheduling, but active flows can retain deficit computed under the old
> > rate.
> >
> > That stale deficit lets an already active flow receive service based on
> > the previous configuration after userspace changes the shaper rate.
> >
> > After recomputing rate-derived scheduling parameters, clamp positive
> > active-flow deficits to the quantum that applies under the new
> > configuration.
> >
> > Assisted-by: Codex:gpt-5.5-cyber-preview
> > Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> > ---
>
> This is bloat for a not existent issue.
>
> pw-bot: cr

Sorry for misunderstanding, but is this patch rejected?

