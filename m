Return-Path: <netdev+bounces-288673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCcuGLTrCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:12:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002455E111
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C08383003BC8
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5735538B12D;
	Sat, 16 May 2026 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9w5ZlcZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C42389469
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969515; cv=pass; b=T3nwX11FT0NNBKVndGRhngTZ4elauCz2wApyBYhSikXQBXeLPyUJJ2LEj7Dbe3oSLOt5flYFbmthc1h7zYQ9BK921R+R4nw46ATw5LG3zIHucOa59n6qoZBW5IzcwkxKDGKIFEb5UAQ/vIfqVMKUJYyIiFECKTSVuSpWNS3pRtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969515; c=relaxed/simple;
	bh=cnJK7hPTmkgkJZ4VYPugj1Q0LxboZQLhwA40hNOOokM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyLHVIu9yk6BGheeFRszJlmNLTCqn0lImYWXmI1oO1lwozLh42Wc26xxjRt3yVIabr8Psef74kgsq2bUU0KbpeoQIV4eo/yXnCvp8ZQKOPSvwlugIoUVrjls9Z1tWqOhGlLpt1jq6mZPP/8BAv2pIISjR1sySwlxMap8GgJsbWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9w5ZlcZ; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dccb8644c4so628973a34.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:11:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778969511; cv=none;
        d=google.com; s=arc-20240605;
        b=AfCB3D6o5L4lFLNivkcUj2ho0wF5lQeFDBUdd5g5Bt0Yrfb/gAxQztRzuhBwz3r6Nf
         HFaDigYxIpsX7mNm5s4hGrEV3XefCnRlaL/wpAMFdplVT01I0bVbagJvvsnbiJo1EOgn
         VJB8zIcGfmswPvCXzYqaaom4dsp8kB9khG2os/4BgBPF3tQI+g7zgZTnINstXxhgUaFG
         HsnSSbZCE3ErDzkfuwpAFEivH8RRhHe4RKz1WmHcAWRyJZSmzKMcR50Hv8j73BlfK0hu
         9w4+pcTeUMmQEowdZGPRGS2Xg0BeCCR2gty95IqM2bs5swzZQ1wqTHZvg62qHk2Vt55M
         Lr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cnJK7hPTmkgkJZ4VYPugj1Q0LxboZQLhwA40hNOOokM=;
        fh=9MR6mvH3V3W++GQTqU074lGLHVDHPmZSlUu55UgxTkY=;
        b=RwC1u2QQB7EFjtId3J53pN2lL1rX5HQ+GiJvordbekHBV1TPkTfj+wQ546bUhdZJuG
         KD//Bc+kwllBv0PoZ6jm2WwUl6qnfdnxrBLduLMwtfNz2bybZvj2AppL7rYxPgmTBQ12
         JappGKif3mCArD1UF1x/fXCxXizf/hNnwhgjZ/qAydOA+lYc5I4kDW85Kkk7xwqBQyrP
         rz5it+SUOGchJ/ipsXmSJcZNx41Ezx2UME2Pv+lnRBS+t+mEIO5afxuBzedmH7hkqbJA
         6dk6zS5PoWOVRrsGtX3vVrJXdsYw/HHExOvbSDvuKkBBTaaZawkBFDxRn0ym3qD7o0Rh
         QSbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969511; x=1779574311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnJK7hPTmkgkJZ4VYPugj1Q0LxboZQLhwA40hNOOokM=;
        b=a9w5ZlcZOPp792MXsUyaTY+CYC534mQZvkdkhyafLmCaY6wS1N+ZB/N4YpNxcGthL9
         WE0weftYvcv6En+ilYJkIAvPLsRxx9VYS+MBdMjXfs0F3kEu76+Bhgfj3v8hetMy0xnV
         /ZKTvs87uvlxHCnN66DX+o/queRkgC5XFCKZYTYxc6dxzDW0jL6yO+robfnJ82u0yQ4F
         YSJHWzNKEVOaAOZ98mHngwcz+yoYafTGs3z6ldDVcFf2n1Nv+1C16zV2JGsQ8jGb6NWz
         sFggLzXCB6Mlaur/hnZrRQguIZC28C4z8Pboa0p+bzhpPjyIqqQC/RmqIy1EWdYHNUoY
         PpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969511; x=1779574311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnJK7hPTmkgkJZ4VYPugj1Q0LxboZQLhwA40hNOOokM=;
        b=acbaQkeV7iodhIBulxTQqKG6tpM8nzY4eKz3LNIzNU05Ttt4D1Sr/rZZQAxVdMEoN/
         sGpQYTpAwpNotJ7Z8X9Xn6WPYJuOuzC1op/EYlSxJBJ8o6THZNMlRgWzh+uQK4mamMmA
         bqjF59Fs+bO6LPz89GINRwuHmvjfpc+F3VFR6lN9Yqj6m6nMfSFNZiJdpeVssMPN3skL
         LjfrcLECFhBOD/LHWe3gXA9RXskpKRMeBh/Paeix87R5/hErdmUeau9iAs59Y/7oDfM9
         gPMKrbr8PI1dDZDmVTeoVPL5+H/lz7TN+4uVw29NqeX05X6yC1MWfSvCgKrhny7kNEVV
         nxSA==
X-Forwarded-Encrypted: i=1; AFNElJ/3mer5Gbdl0vaW90hQK/PkngBhu146oOCxumZTU31D4ddCEHPHL40m4BUY/EqM9qzNiKF6BUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRi051tuQM+hh2Beh/5V0T5XRNYNvc//cvZ2+XlkZaHxtT6MJk
	EVEejL1tKjFo/+Kmun0otpiq36Ze9x/U6P8FiTjZehFLEgP4X75slZnTMs6RBjwTiABHORWFBQk
	EdYth+76298GxRTGTRrnLomiPFE1s6Ek=
X-Gm-Gg: Acq92OE8D/mxg3Xjq4q+n0RIR4qZtMwnEq2wTPGuXZy3/BWzvEccu6heUN7blSCkhzk
	+MijHCxaArsM4fJXb+Aqglm+K/0RXfpC2TlIG7/nyUobYEZXARycmYQEMv3/TN86BZjofPnoFe7
	rbEkYue8vbiTMEd6CJpVieVKEU5nMW2sCUfWwhZMdXnkcdZiQLogAyXi+yp36RAc40Q42Ap+uGd
	NG1T6+mefX+mDOhZrvWIaJTiOza8popwMIlq5vwVJma0csfFpOKiMLuNyFyqSEP0nXpq6Dpmfkx
	xqXftw==
X-Received: by 2002:a05:6830:6183:b0:7d7:bf59:16df with SMTP id
 46e09a7af769-7e4f2bdad0dmr6831364a34.17.1778969511382; Sat, 16 May 2026
 15:11:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515174904.28575-1-contact.kartikn@gmail.com>
 <afc61e48-5380-4764-8144-db69e4dc728b@kernel.org> <CAEqOmmXLT+mdv9ziirkeYF0cOq07veoFyxOMhw=D01-qD+icvg@mail.gmail.com>
In-Reply-To: <CAEqOmmXLT+mdv9ziirkeYF0cOq07veoFyxOMhw=D01-qD+icvg@mail.gmail.com>
From: Kartik Nair <contact.kartikn@gmail.com>
Date: Sun, 17 May 2026 03:41:39 +0530
X-Gm-Features: AVHnY4INoQJV1aBYN6-0jzSGu_PNz3veVm540O4HGcN743YMvi17d9WPa95jp1M
Message-ID: <CAEqOmmViMN0h+PCTd1_1sGGozc3RqMK_Nj=ABArKTwWMy8XXhw@mail.gmail.com>
Subject: Re: [PATCH] net/llc: fix UBSAN array-index-out-of-bounds in llc_conn_state_process
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6002455E111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288673-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[contactkartikn@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,628f93722c08dc5aabe0];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Sure, by "direct path," I just meant the execution flow when
the socket isn't locked by the user (!sock_owned_by_user()).

In that case, llc_process_tmr_ev() immediately calls
llc_conn_state_process(). Right before making that call, it
checks if the state is LLC_CONN_OUT_OF_SVC and bails out if
it is. That's the path that is already safe.

The issue is with the backlog path. When the socket is busy,
the skb gets queued, but by the time the backlog drains and
finally calls llc_conn_state_process(), the state might have
changed to 0 via a teardown. Since there's no re-check there,
we end up hitting llc_offset_table[-1] and triggering UBSAN.

Putting the check right at the entry of llc_conn_state_process()
fixes it for both paths.

Kartik

On Sun, May 17, 2026 at 3:30=E2=80=AFAM Kartik Nair <contact.kartikn@gmail.=
com> wrote:
>
> Sure, by "direct path," I just meant the execution flow when
> the socket isn't locked by the user (!sock_owned_by_user()).
>
> In that case, llc_process_tmr_ev() immediately calls
> llc_conn_state_process(). Right before making that call, it
> checks if the state is LLC_CONN_OUT_OF_SVC and bails out if
> it is. That's the path that is already safe.
>
> The issue is with the backlog path. When the socket is busy,
> the skb gets queued, but by the time the backlog drains and
> finally calls llc_conn_state_process(), the state might have
> changed to 0 via a teardown. Since there's no re-check there,
> we end up hitting llc_offset_table[-1] and triggering UBSAN.
>
> Putting the check right at the entry of llc_conn_state_process()
> fixes it for both paths.
>
> Kartik
>
> On Sun, May 17, 2026 at 3:00=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
>>
>> On 15/05/2026 19:49, Kartik Nair wrote:
>> > When a timer fires while the socket is owned by a user, the timer even=
t
>> > is deferred to the backlog via __sk_add_backlog(). By the time the
>> > backlog drains, llc->state may have been set to LLC_CONN_OUT_OF_SVC (0=
)
>> > by socket teardown. llc_conn_state_process() then calls llc_conn_servi=
ce()
>> > which computes llc_offset_table[state - 1] =3D llc_offset_table[-1],
>> > triggering UBSAN array-index-out-of-bounds.
>> >
>> > llc_process_tmr_ev() already guards against LLC_CONN_OUT_OF_SVC for th=
e
>> > direct path, but this guard is bypassed when sock_owned_by_user() is t=
rue
>> > and the event is queued to the backlog. By the time the backlog drains=
,
>> > teardown may have set state to 0.
>> >
>> > The direct path already handles this case, so the same check belongs
>> > in the consumer too.
>>
>> Considering you sent similarly complex patches to MM, WiFi, accel and
>> now to NFC, I am sure you are using LLM without disclosing it.
>>
>> Please explain with your own words what is the "direct path"?
>>
>> Best regards,
>> Krzysztof

