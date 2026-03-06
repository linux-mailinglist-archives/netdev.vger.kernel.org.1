Return-Path: <netdev+bounces-264900-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJWeJa8sq2n6aQEAu9opvQ
	(envelope-from <netdev+bounces-264900-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:36:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E4922719C
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 20:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40BB9301DD93
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 19:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9B37268A;
	Fri,  6 Mar 2026 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xD0OBVPW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED98636E487
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825767; cv=pass; b=jRed8futrNS52gVttBSapo9+YzL7glJJilWeRPLWMq82TTSTxblTHTNN4rPW6wBOJ/uEcYP2O2/G6s2CLjVzf0swOm3+QccM0t+czwr+ykn3IgHrRTFafSQ7PE5NB+BW+j4a1XzFa0zRBhZNEVequ9lzHWBUJl2LGAwDltj+jIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825767; c=relaxed/simple;
	bh=xdj83dFgVsPH9r/XNzb+YVgn9ygjRRPVxKePJgaQ38o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wykbg8w7QjO0HgfZDNg/i8MHb+Yl8jsDjh0mdXSo/HBJLYa6ObzCtUc1QkThWD3OHKwHn9VpgdxG8w8kNbRJl1qaDrZFyqvRiyHqxYENlxWcj8pofKnzOSsuJbJHg2PAEehuicoiXEQKktVf8R9y6yHVsGWoX+hFvPgVPKyzWCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xD0OBVPW; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso4299922c88.1
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 11:36:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772825765; cv=none;
        d=google.com; s=arc-20240605;
        b=Ma2J3B13/ohV+Qq5aH/02svZ1S9w21gPBiSUVmxHOqAVZYXs0jimx3W7pTJZpRhPk9
         aBY5wYj+wBdBgZkz2iHpzpWk1V8eRuIPR5qjKCM5w+mhRmyxdB8Wc/hDxR4iXPPGLn3q
         kJ5qTOiOTVCcQYMupewDyJOPLND4972xxQcIL7iiKmm5/NdczeNZaO8y/tIE/s6Nt5QF
         7b5hvLLkB8NNy/GkNuVpgXSPV/LIVN13LOr27KFgF4ijC1N6KPYmFaF5fPdg/s0++YpF
         lqKjS0rRfhlwnfkCg57eUDkL+nNK1RKre87rfJ8SCO/6nnM2jMQMF5Zs7ax0/Mrc+o5W
         8HFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdj83dFgVsPH9r/XNzb+YVgn9ygjRRPVxKePJgaQ38o=;
        fh=eswoYjFIs3xBHOaqSx8WtvTnbHViVhO5by1yylIUcEM=;
        b=Rm4kDSMqPWWMQHW8bEAOHeaByCNM++REM9Q9aOnnofXdc1ZHxJFU/4p7ySqrpVxTsM
         xGCH5W3Bbow5kvaLG1WDhoAKR/el3NofxVTXsQrM8xO2mRZy2LgSiuwxkchieLstyfD0
         0y5SytIa/R2JgxWss/bHxqzaVXLXAB6LBdBTSgwnC6o27CInLPOvM+SHvwBcjayqftKN
         iBexfcVNkRYwHEbhcnn6atQIDb7gd2rYVQDSOzUItOHtKFKqPHqRrc1RCsbqU1p+eBpc
         6aqlhNlxQpR+W2j3CqfgmIFXFGZ10dZxxEQt/3TTwj9znmJ23KQ9Z/MB+w9v2N3it5Zy
         /h1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772825765; x=1773430565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdj83dFgVsPH9r/XNzb+YVgn9ygjRRPVxKePJgaQ38o=;
        b=xD0OBVPWlVpZGXVZE7uR4vPE32lMwSQiRO6szKOLf7/xcDqxPcksp917LeZkxfc80k
         dGTwQl7XdlRT2zLAfRJ1slRVTJx+YcuxNZ9bMXiNKWe7U4b0HKqnQWh4mVy3Wo7XfDLt
         5viiV1p5keN4/VtyVYumWThNgIpSkkV51nkwiEfjRNbt48HBzIla6kQtp4jw6RgwSemr
         6mK4stEqfUfAjU0y9Rwb8gWFoz1BAe3H0NwuLX57Bpc9EJZpzcud4DEJhHT2etK416WC
         5FqADWnk17bDZf5rp2ZuthWhTJAN0tmYYovXVP2cgVIMqd1vS+LSR/AYdnpYhYHQqKnK
         y2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825765; x=1773430565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdj83dFgVsPH9r/XNzb+YVgn9ygjRRPVxKePJgaQ38o=;
        b=owLd2BuNX//dDDratAuyyLi3QFfclh+lJS/vxgiVlQiKwSA4zkMPNCX2kOu/+JJESv
         Wz/wLWaBOfBNaDiurlnzEr3AoEjUWJhC+f3H30KmEvOaWGC3/e5DIOWe6wCIvm0IKmdV
         1MVNbS1ePfz/lZBhqTqiFTAZZ3jCyBo8fY5iicgvJ0T+BSbV2sj9kzyfwKV2P/wIlhBD
         VZu4g8/HhCDnA5zMFOy4PSscoasYUxMz/lNTcna/+Na2o7U/wcYnCGvzNQ0aJDtLU6G8
         Qa+vyaJvtwSJKWz/hFZVDWulihA/IvzkRqyohFB4wuZPM9c2aHlJzPffYuet/XwYnPSW
         iN4w==
X-Forwarded-Encrypted: i=1; AJvYcCW2Hij6A7I+I4BZ4MbEyiu6ks7qFTeYj0bvzsRHRT0Bq5XhjFXupzFvRKrkvKtSrUqpMYPLgq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb/8faHbhGY9Gn89Kk3TPjYFJ1yX5XkwcJtpBC7tSGUBldAsFY
	QLeyka1lsT2xh8YFGcUwyrnYIdIUxtXxkFEcfNsXPC8ZcEYURCom9OLyKMDR5VUHCs/MNy2kNVn
	Fp12QEZm6htI2OsBChnousy66dFcl5iEh8SJLkkG6
X-Gm-Gg: ATEYQzx/wFO7feAZc+qwAv/jmDbvqLEDrNk6mSDrghs2CLvVeUb/JxMylA1+2Q8MsWk
	z2DmRaQwRqRSyQqrK/6cMw74AytvjMDHXa2t16pWClcK6nXYhg/86BYJTjV+yF/mM66AwJh6COj
	bA06OXHvIeCnZYqADYG7GYIP/nN8gY+EAPuP6T7L9qxDXc2EPqoTBtDjSXV8VEWC4vrwwz75AAW
	x5nEHiiux0vYS6t4lU3Beswn+6quIUHMbM0DzIkySP+7SJov5j11CcDZfBek97Ufvi+g2TQujU5
	PsB0U8jN6E5dOw8T/oMnhTtIJC+rcCVsfcFDJlr1G9oBahn54kBR
X-Received: by 2002:a05:7022:e10:b0:11b:88a7:e1ac with SMTP id
 a92af1059eb24-128c2e0b9f0mr1601763c88.19.1772825764585; Fri, 06 Mar 2026
 11:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com> <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com>
 <8b43d234-867a-481f-90e6-e155132100a5@intel.com> <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
 <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com>
In-Reply-To: <7c8ed118-d3c3-4bdc-913a-14f5537c44d3@intel.com>
From: Steve Rutherford <srutherford@google.com>
Date: Fri, 6 Mar 2026 11:35:27 -0800
X-Gm-Features: AaiRm53_WNbb-NVZ7tDAtTMf4_ey8XW-RibCZZ-eM0UsuoJCw8DO4Max1MVJZ18
Message-ID: <CABayD+dJOxYxZYBpUP06sbgEf4rzMTiVfdmqbR4wnY9C677RFg@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 13E4922719C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264900-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.944];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 6:52=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Steve Rutherford <srutherford@google.com>
> Date: Wed, 4 Mar 2026 14:01:46 -0800
>
> > I believe syncing twice isn't inherently wrong - it's more that you
> > can't synthesize the header via the workaround and then sync, since it
> > will pull the uninitialized header buffer from the SWIOTLB. Outside of
> > SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
> > are copies from/to the bounce buffers.
>
> Ah I see.
>
> What if I add sync_for_device after copying the header? This should
> synchronize the bounce buffer with the copied data I guess? A bit of
> overhead, but this W/A triggers mostly on stuff like ARP/ICMP, "hotpath"
> L4 protos are fortunately not affected.

That should work fine as well. I'm not certain I have strong
preferences on the right answer here, other than "does it work and,
ideally, is it less confusing?" The patch I posted is a bit
unintuitive. I think what you are describing might make the workaround
self-contained.

thanks,
Steve
 [And sorry for my gmail-driven top posting crimes D: ]

