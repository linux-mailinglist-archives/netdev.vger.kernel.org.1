Return-Path: <netdev+bounces-282884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BFeHINl82le2AEAu9opvQ
	(envelope-from <netdev+bounces-282884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:21:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6EE4A3F86
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AED3E3007B14
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D447440629C;
	Thu, 30 Apr 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbdIDG4p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E740B6DE
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558909; cv=pass; b=s54YuTPQUJlAyF6SG+WfVtnVYK5xf28CX2kDceQZHSzCe5LaFi/MgJkKJaI7bybzxNp4QXJ7AM5PNgHINrHoSvKKO7wzWuIkKBwIe45wwAhVgI5kZ761vw+mA5IEhCVZ09Ihb/VpJL6WxEv+Ev1FJ2pFLprnXxxOrbPkmcioSMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558909; c=relaxed/simple;
	bh=ibVh3c5305iUKdF/FHfUnvLzIUREZVrpImUBHgzD1XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAWb9aYHTTiyoti1r7rGgHNPQphaCEr2aVpuG4J9lNkKmroz7Ku3e6Hvx421DJkDB66XG1TlAvCIi/xUuoQ2wRUc60jdihOXLibTwYUMwWFR9yCDcTHxo57a4L7cAq/s7Y6H+FxRiJsWp8KkP0sUaheIHHg+pRc9/kzZ+GgCXJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbdIDG4p; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d836552daso596651cf.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777558907; cv=none;
        d=google.com; s=arc-20240605;
        b=Kty2obHUJTcb+CTBBdzKWcsBORKgvQIDzkk+y+07yZgb3gY8BXAkvQuAxAf09Skfxj
         3YJ2tDwXQI9N4tjGdmr3nHcItCDAtTMxvlGUZ+pk4yAoGr/gg1pbKLQC+QkRgozbUEik
         ut52Y0EsSy/8N1MqIwnQ5rGySNE9kJrUvc47+IWqCFv7XhinoSh7SD0M8C+1F1olI4Qu
         CNQnWyrCw4qESiXGyaMEX4RTeZrgQI6GzoFXGPKsC5LMt86oI6aYW/nb1K1fvbciPWpV
         kR5sXZoqwRa4U1NDz17k2cPcZpZUH1LysxNDbemicWqpo2iVsc3HicAmObqYp7r0VYBl
         NmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ibVh3c5305iUKdF/FHfUnvLzIUREZVrpImUBHgzD1XY=;
        fh=rerTHHIhCDoVeuGyCirwSDU3IA8cQo2gkqQZRhU2Jps=;
        b=NG1p6bTZ/6yWtmnVDXyllCmIAPIS2mlRrpL17BSgLI4Z3+CoKRvcVlwJwv12UkuV4J
         5d/g12ooZONVtF3jAYXd+SrLMq1oF4Flcz9yyQcJLgTkvLusG+Lvz3Y3A9HJuGJADDZr
         45NehAX92MfX8YQPd+zeKPdgxkcZbslsurfOhBY+fo9oIqZ20QY3dUXmLWsK2CCPWiOl
         g2f3Ir3mutA6QfM98PxJBZp0Epuri52IlJTBAl2Ww61NaRRpTDoYpZ1UFgAH+d30rMcC
         Xd0HY9su370is85hqpyXidsiXxgAc9KI/Em5/sJ93AwgD5hvPUNkKSix6KY5AmYsTQi5
         3C6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777558907; x=1778163707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibVh3c5305iUKdF/FHfUnvLzIUREZVrpImUBHgzD1XY=;
        b=vbdIDG4pZrYh7HDzW9Y3Zkn6lquGJ59yWGR1TuB+btNdEv/MLNK7JTa3uTs3d5Ji1A
         FUenDcD4hs45D/Hk0lr1ArT0o0+8u7mqddyfw/kTZIqcfCE7dzl9kaTHxhnW8q0q8E+D
         7ZO4UPHWQd2H9AkhZGii/xrdffKc4rd044FdDM1Ajr8MBbpU9cPYJrFRL6Q39mnJtZEx
         ybczTtKqpRi6uEAdfI6cnULkMYUybiR96QfoB/0VyYG3EGnO21Auv49L82prsvW45qQq
         QwKNldizlo7BdS+gGofR7hB2CW4lcm4TL+A8FAY3oMVSHVwTF0UuY473Xssej+GQVGMA
         iDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558907; x=1778163707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibVh3c5305iUKdF/FHfUnvLzIUREZVrpImUBHgzD1XY=;
        b=PdI/MCILCzD+/+gfcOXyfkGDj1GksF9yfziboPwxqI7wNQeQzoSowcoFpKIZvuGNPU
         C0ItU2SWd0vhAL1AzWJpNh/5OgBxfhmxjuTPPwiemmm1FtkZxYjY6O8AYvWsuCdvfH4/
         ABTb/u03LIsBt8Up7EEslwOlw101w/VKNcze2pDK3iYqi9yJ5alNPy94+PWX44Vho+Za
         MSxmwzRdSjvVCpoKN6uN1KMxMyA4/quo3jlVVRBbJ85Y4c+SDlEfavIT+PBhReUc9oh3
         mL3bU+xx1gQco0YZUbGMT7R654IzpU7FN7ituXAk6A8iiCRP9DYIVzG+VtHaJ3a0/Sq+
         T0lg==
X-Forwarded-Encrypted: i=1; AFNElJ8nxw4XPQUyeHVk3VC+yXGWbSC6QPweiKS4Yy7QBY/VSnKVR1xoQor5hnNAVqZhxm+AYLlaVDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCOvg6g8J0ZtUerbqEFu0o+jtf7R0g9dBwm18Lwb8oU1UKWlu
	ok2PCu0DOZeFYTuH5BbdDmCSrX6M4KujQ04V+kdeCqbd3EM105TzFG8fqGd8n/hH2TLqZJ5n/Cr
	WJMuzIRtneiiUhU2rjtKLvGS3bo0QFrJTezpmBup6
X-Gm-Gg: AeBDieuZZAGZ9i/L1jKlqJNd4wmsNCTp2RhnwPbbXQhEofzGDmySvR3KrCK+1Hbj/U+
	UBzfzLjlKWd+GLceeleRbl61BngpfVfjbZ4/u0PfNc7vTbsMZ+rC03gQCZWxynhdZAEWAj7dScr
	8WKdSN7ZvT7GyYp/+5uZjL1JcTar6NbwnO0KB5EahnxKUngdTgV7UvHjrrFcm+8S5hfF/jJxLZ8
	YUIUwQcd78/N3+AxWw/MM/MnWNShYq3+sYuZRZT/DIgixF+fLIpKUuvVsAIQkGt/ck0iP6W15y3
	yYbVCinYAczG6rAp6SwOWFAizgff9em6B+N/z+a9wOLggCAwBzSIs5Cn/JDmD2zim4sbB6Vsdpy
	d1FBT4rBH8zvUQqXPaQ==
X-Received: by 2002:ac8:59ca:0:b0:50e:5e19:587a with SMTP id
 d75a77b69052e-5102a3d3061mr12409231cf.3.1777558906644; Thu, 30 Apr 2026
 07:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430021444.2929534-1-edumazet@google.com>
In-Reply-To: <20260430021444.2929534-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 30 Apr 2026 10:21:23 -0400
X-Gm-Features: AVHnY4LJpsTpu_KyhbVHFFrPFWxvhOjifWTFbSVd8nPlQ846loyh3E2yU6R3vCw
Message-ID: <CADVnQy=aaa7OBd6hjxjwR=9RfYSoJGVeX9ixbCfdkrd7px0HLQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests/net: packetdrill: add tcp_syncookies_ip[46]_9k
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C6EE4A3F86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282884-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Apr 29, 2026 at 10:14=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> These tests check syncookie mode is able to reconstruct some
> client options when TCP TS are used:
>
> - wscale option.
> - sackOK.
> - MSS (in a limited way, especially for IPv4).
> - ECN : not enabled.
>
> Note that IPv4 and IPv6 have different msstab[] values:
>
> IPv4 msstab[4] =3D { 536, 1300, 1440, 1460 }
> IPv6 msstab[4] =3D { 1280 - 60, 1480 - 60, 1500 - 60, 9000 - 60 }
>
> IPv4 is currently capping SND_MSS to 1460, even on a 9K MTU network.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Very nice. Thanks, Eric!

neal

