Return-Path: <netdev+bounces-286202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC+WAmhw/2kx6gAAu9opvQ
	(envelope-from <netdev+bounces-286202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63C500CA9
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09AFB300D15B
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D02E7F20;
	Sat,  9 May 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUc9ICcd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132E253958
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348133; cv=pass; b=cP3QoVQeCQkk7R7VwZtHOrIzICujaoio1H8z0fPHBeNPoXLZI3Dmt4s/BRJ6gGz2xk143b2H1PXZXWR5hXS1GyhcZaE3cvscybHpKTDQn/05PwQnkak+ypP/QN9ZSVL6PFWtYkL3xoZPsV7f2VyeLyYkkz/SAMp4xFyd9UXhZ6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348133; c=relaxed/simple;
	bh=BNVJivfXYFIEMmnZvgiBuIroH5sJ9sqppVqbhVWqU4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/EsUcJaNgJBeV/xb2pjcEnW5UlIe3qbXCPzd98kdvZ6UOnIb/pensZTbs4xcEqDHzrrZPTNUoLrymzO9fNEF9SABImBqWhzTGQlBUeSPzDJV5aDmPsDiuwfzKIW7O1iYcHt5nKd/76OaLdi9CZdlt9qT+31rkOlawUNU750ghk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUc9ICcd; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50fb8e9a4edso32981661cf.1
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778348131; cv=none;
        d=google.com; s=arc-20240605;
        b=V7Ml18bGDO2GBMZqK1h1qA+jgDDvK8qe10lOinUYqrHZ/+U0e1O2ZRtexCTMLAAg6D
         w2VLP1KRAGa++1UBhGNQolwtCoJxR0OYtqNwD97lH0us1BSqnOqdq9vBtjhtWCpB5mmn
         9cv7o6RK8YhmP2yXgPtJg3yzDHZnqhO5KcEK2sS7jqoLOZgCJy9W4yjchl2ZXiPAdNlB
         MBlRKh+iFZPz7VSOKXyxT0RaInM8ANg1Emvm1OHNsAbCH2xlutmEHJ9gAz/cjB+GA4qw
         1gwsum9HPdV1WOrhokZQywH2A8rcCkXQ7mzEs5rcHpLAp6Ru/3ZmVMtoCTN4aN4u/b0j
         xBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNVJivfXYFIEMmnZvgiBuIroH5sJ9sqppVqbhVWqU4c=;
        fh=OleUC13KhMU2w9JY6LrKurTR5DJ6kiRDRXiwGU9AYVA=;
        b=O6Ny9H7tS0/KWfII52nAAEy/xMH3njiD4HgjO+Dd4I+UareXOBIeL4oecbZfokSKHL
         9LGPNhE52x/GB4bo3zTRbVNK2ZblJLgRXsOz8NZDDVbEP32EoQVnEqvJ5D//MkEfPxnP
         bgrAnPytZpSx+l0mykcC1wLLcLsZQVOhMwDp60sJMIhb/TqAJTglXDmT/2qABFW94LEA
         dScNLsgRQwaPpSJnpavi2jC2wnE6cohj3AbpkL0MgJB126qdL45fLXklRV6bE2traI/2
         YuqvI05f35hUIIsVGDpRd1ehhetEZnMBKUejrY2/92hLyKoVDHiszQYIORENA9VZE+c1
         kepg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778348131; x=1778952931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNVJivfXYFIEMmnZvgiBuIroH5sJ9sqppVqbhVWqU4c=;
        b=iUc9ICcdmTWCTQfEQ7fjqcjUhyU3s5ZMNNlsX+lwIBaPJUcxWZ4f/wsumNPj003v7D
         PB92fOTw5GJroV1tmWayYEWt6EfsrAyxfJZM19GlnDayfP8vFAZybSPtchR72grtEjob
         AHvR2L+lI0ebGavcWk5YtuWUePBvRT+F+vTk7SA3cmx7KjcsGeRFhETCXa0TGLOA6/Ww
         4C2I7+kRYa6cJ6YkR6yMvDVJsAcDaiunq8z2P6UVyFnwh6JVC1ooUOBu6/pVgnjAJ/R8
         3mKLEYZ8W3CLvtHfEOQG7ukX4fCW1G6eTHK80F5RiyUFAQpKQkFitoNk04TDFhVV/PMq
         i+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778348131; x=1778952931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BNVJivfXYFIEMmnZvgiBuIroH5sJ9sqppVqbhVWqU4c=;
        b=ii4orAso3M6qDZ7xlINUFWKy00p0wPol2hKy1tyim/r0WayhfEffcNCnoI0BqB15I6
         8hsAJxX8+uATKnRrzebN7gO39VRNQjhimJNU5TMVyFDaWLg2A2UI3cFsvbEq2s0ASJFg
         ChfUVzDiCBHOkMlr6oVbJXTEkHh8VDILB9Z1bZdu2XG9eLFNYnLZEOikI5fgh7lkInRz
         B+E06ZermfW+IeAQm9dD7dsn1uA37vPwYOdWApuwrknZQcnm8l4dZToGIPlJxY8a+xW9
         4N0oYFfegy8RIO8K25l2+FvxqhedQY6jS47tR7WlpyoLZF2lEKi5cOgf2QY+6FyTOXGj
         NYIg==
X-Gm-Message-State: AOJu0Yznl1SoNOsSV8b+SKVxVcLDl9UMZJ6D+cicDEATm3nl9CeL02jE
	qauyJqQHv2gFZRfPUxrkwtaxRr4ROnG/WRIDN7wsH/16pkLAlvqkpIOCgK7PlnvGfEQd+DjF5q6
	zKzkWmuLgMiQzpLekNPnE/8mPogrWKB0zOs7iIhDM
X-Gm-Gg: Acq92OG3afmSzF2xZPP3PZlJyKTwHI9W62Qd2BTc9Omy0orlkkhI3HU7fqfgljHkglg
	25UKXylQXTiKPzX0l0azqPULf/qOTiJDCxpoeNW7IMUpgzQAkxk8IFfm40WLnehhqk7+fvZxA1I
	8LM7uQU4L/jjFbvWoAF054qLhkaAEiyLOEE52p/P0pRHyHipqmqEdhzd/C91vsckxc3mTDgHldM
	EJinlhKqLIrAw1su8tzmLSmaJR+Jaywjwa8tOA3bgSmfODi+RIptpPexAj4nBytoDPom2XT+fO7
	AOFL7CMaP8mn5cQ922kEtufzxXbiqi6lOXODR9nCllkOYbWmGg3Fgo3utnJTHYqnZ0U8tBU0y4Q
	+WwI2Hg8k0FVjhmMvBvYqCxwO/46aq/A=
X-Received: by 2002:a05:622a:352:b0:50d:8db0:7abb with SMTP id
 d75a77b69052e-51461fc4f53mr239015261cf.42.1778348130157; Sat, 09 May 2026
 10:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509100129.479aec7e@phoenix.local>
In-Reply-To: <20260509100129.479aec7e@phoenix.local>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 9 May 2026 10:35:18 -0700
X-Gm-Features: AVHnY4Jpb4nUxxx6qtaoswYt2Vy5r7GPyJNRsR_wx-iG3iu5M-KD9amy-rnOFqI
Message-ID: <CANn89iL_cgqYfycsKqV0PcHn7b3kbZveqLndEdcQOW64fRzaww@mail.gmail.com>
Subject: Re: Is current INET_ECN_set_ce() safe with cloned skb?
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <hadi@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5D63C500CA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286202-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,networkplumber.org:email]
X-Rspamd-Action: no action

On Sat, May 9, 2026 at 10:01=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> While doing changes to netem, Sashiko flagged that INET_ECN_set_ce is not
> safe on a cloned skb. This wasn't something that was in any of the patche=
s
> it was a "drive by" in the review.
>
> But it got me thinking it may have found a pre-existing bug.
> The function INET_ECN_set_ce() modifies the skb to set ECN;
> but skb is likely a clone from TCP. So modifying the IP header
> to set ECN will modify the version that TCP is holding as well.
>
> The same pattern applies to cake, choke, dualpi2, fq, fq_pie, gred,
> pie, red, sfb, sfq. I.e all the qdisc that do ECN.
>
> Is this a real bug? Is TCP just working around it?
>
> BPF is already has fix for this but qdisc usage does not.

TCP does not care, all headers can be changed freely by lower layers.

