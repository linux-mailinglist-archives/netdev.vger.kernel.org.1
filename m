Return-Path: <netdev+bounces-251440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A17D3C51C
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CF7258ACD1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7A3ECBC9;
	Tue, 20 Jan 2026 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RaYwrACB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F283E9F98
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904323; cv=pass; b=BWpRJj1xo3rHzJcWPBZ4J6zdqBzvh/aV9ke30DHHl37N8Nk6m8k9BWc09Kr64OqXeiLelxlkRqnmmf+8zNUuVhNiOF8nsq0GSV1wc2GDKv5u9BYNwi5kDO8ow3QkxJssfLfoGYhMw2CgECGEXs59ZmgBLUUMsQGkUE2DmfoZiuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904323; c=relaxed/simple;
	bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifNb4yNx3v1//LDDI4diWpC6vx9tVQHgBZl8YloyraLhJ288sdEiSw+sZDdIHITxezBy7tWIpPHL6d/dMzZgwNtq566MonaOamIM0bXb++u8ea2LcooPYLB5emDuHj4q7VF/wgH5VFk+Nzy9ZlZO2EsZX8GIT4jQny6Zyum/86s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RaYwrACB; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b7de222so51810131cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904319; cv=none;
        d=google.com; s=arc-20240605;
        b=ZqBId4rmGO/eepuZP+E7UTtCQUK82BmamJ/kFAI1G9MiOtTQShIKISDRpKag1Ypoqx
         Ex7YIA/uhZ9f4qMkKSewi5HDhFopnOMRyBTTqzeu2N9+4Ne+vBOtFEYQthtQrrFRteF5
         IkHKb/XsRG5Q8JdOVA7Y/+3ZaOn1R0ZWk87QYC1fIX/LHQ0gYcXTpuO1ZO9YtDgrj20h
         iXQSilLL1QHoXa6tdRnExDrLojJYImeH4Wi7sAyx4irC8CwPkKuYmZxXqWZTjf0qtvpy
         TeeYZwQ5C9BlgEMVwNDdu3rHKc5HQLv3BsHHdkTUW9eiLRzDJiP4QhhAp2qQ3NynJERk
         FYQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        fh=/FlJElhvtO+5TYbdAY/H7TPh0XBEce22JuG/hDZ6hOY=;
        b=Wk/r2IQvnYqbpMA+KGIxY/Wk1o/no3Pix9w00WvamxkCzZyqUU2Qec0eBJ0IvjXArY
         O3sdjdfiicq4NYcKRS512K73jQlH/YnHaBucwyok6wfm9yxaC+SliUEZTR9M+fNU7kIs
         bnAo++U7oMylrXnGylIdqL1mEMF/hXfmfzG2sTrWAESmyXNvAgjOCVzP03uADg7iNsOe
         BJxSCsQXdWkcgrtFrbZryg0gDLRNSJYYwaEFsXU9KgSl1NFDrGWF6b8wNEqjjKAHYU4h
         US2ppmu5HvmatPWCiGPF7PEj2GM9cddalN0Rqb2oWJanzKyrm7FGY4DNabxINRx7pmYH
         x4bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904319; x=1769509119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        b=RaYwrACB1pbJO9Q6eDg48UcHrWDmIg6oer89G3yBKamt5wwYLsIRNgBzqeyZqinyba
         XXViknaRsH9GVvVJsQWjHobR+hK20LmZ+kCnvzRCCkUy2htPs/doFR1WyyU9KtpZ1NT2
         ffDFimp/p0rAcoOXBu2185cRD+C54AinpRKF0oWW07214gGokq9p53sGIEIRu73kxYTG
         8/jafdk3orEy3XR3378E9zGmHbEO++wHIohIOy+tgE2BlOqrNRI5pMASS9G8c+SXVhbV
         ks9AucTDVt+4Zbgyqfty4lHAGyWi2A3wX6dIv6RueHd2dxMa+dbhXLrKkRCMGoK/1nlp
         rKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904319; x=1769509119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3/vqEjOYP5wT8rQWVCJ7bEZ9Lj9Z/WoJtk7uoPUAaY=;
        b=EtfZdWBTEnY9HYNS6F09nH8XBSm4zuaWU+/dd8lV+iyUgn45BiBo+pfseOuFN+ggfd
         KDFqNeA4xdeutPSTfHy5PtTISOZkaYJjkDIlIKDzBcAuBmatqK7Eq6y6+NB7JLLpcmdL
         HzB6G45CYCjig24CPEkak+wbuUeevoeasuII0c+Oo18822O524FBQDEmdBmU9Kbu2fuR
         Ju4W2pPx03OzYLjmLSN97Z2GsTacRN3XWbO6PfC5dEFRlIAiLjPevbydBl/eEA+picho
         BPL0q90O8dFKAQ+QOjuPeXfR9EnErdyXKXYG61/IUApkgFOYUet2Xk80Rp++8PxYAbpH
         q0JA==
X-Forwarded-Encrypted: i=1; AJvYcCV8bapIRWpnrEvlF6+j5A8w+/DkfE98TrdYzNETBNoeHLOmxcNJtwkjMOZ2tsXBzFcERgWAMFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9NoWxbXs577sKgfdeaWKgz76AruSRH2tReJKLPu02ux3StW5J
	EVXlUSCP8Fu4ut3jYNk62HBkg3SE7BgwKSffAdSTxBefO6pnq5lmfPCHR0OyQvnBY00qgYoPP8t
	/hHh/iIxwlpWRMTptHkShvPZdR8yxzYxujQX36v9c
X-Gm-Gg: AY/fxX7b0p77UNREIrlcKu2MFWugUKV83kmYhiE5eWQWAJPi89nupyjOsfmhqA1b54d
	XMgUdLZjnXeuned/zW40s6ZYylOgFGWe4rDL/MGi2QDIMFVy12IFZ3cGNledkGgZBsV/JKNWlBe
	L5NgOKm38jnpUdJLVr9kOepVX16c+LDAlk+2zdUp3jWFtcsREWB72CMRnk8CRRW0V9YCPHJjM3t
	4p2+lRzL/6os9EPdH3++k3MOUPx/eColQdkMGgi/OjdeVI0CNc9aj4NLvK3Mk5EBF7bQZA=
X-Received: by 2002:ac8:5952:0:b0:4ff:8fc7:917b with SMTP id
 d75a77b69052e-502a17d35fbmr194387991cf.80.1768904318971; Tue, 20 Jan 2026
 02:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-7-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-7-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:18:27 +0100
X-Gm-Features: AZwV_QjH7opN_HPqvhqUNXEbYAFk1K1nGv7G-5WTlprpaA8RI4H5El1vduIS2JM
Message-ID: <CANn89iJHz4ecnqfFY9F4Mkb-aKCiCRhtx8++YvKPZbSHy4NXGA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 06/15] tcp: accecn: handle unexpected AccECN
 negotiation feedback
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> According to Section 3.1.2 of AccECN spec (RFC9768), if a TCP Client
> has sent a SYN requesting AccECN feedback with (AE,CWR,ECE) =3D (1,1,1)
> then receives a SYN/ACK with the currently reserved combination
> (AE,CWR,ECE) =3D (1,0,1) but it does not have logic specific to such a
> combination, the Client MUST enable AccECN mode as if the SYN/ACK
> confirmed that the Server supported AccECN and as if it fed back that
> the IP-ECN field on the SYN had arrived unchanged.

I find this a bit confusing.

3.1.2 has :

An AccECN implementation has no need to recognize or support the Server
response labelled 'Nonce' or ECN-nonce feedback more generally , as RFC 354=
0
has been reclassified as Historic . AccECN is compatible with alternative
 ECN feedback integrity approaches to the nonce (see Section 5.3).
 The SYN/ACK labelled 'Nonce' with (AE,CWR,ECE) =3D (1,0,1) is reserved
for future use.
A TCP Client (A) that receives such a SYN/ ACK follows the procedure
for forward compatibility given in Section 3.1.3.

The relevant section in the RFC is 3.1.2 _and_ 3.1.3 ?

Honestly, AccECN is way too complex for my taste :/

Please copy/paste the precise RFC parts, it will help future maintenance.

Reviewed-by: Eric Dumazet <edumazet@google.com>

