Return-Path: <netdev+bounces-257779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a2PrE3Kwh2nwbwQAu9opvQ
	(envelope-from <netdev+bounces-257779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:36:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B06941072B4
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C3430117A7
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084872F39C7;
	Sat,  7 Feb 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/5cK4Rj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C075B1E9B3A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500205; cv=pass; b=AVWLSchgO/uuDfqfNLIkk5ey7y51kWgPQ3mS1T2JuZxzXH9XRtY+FzauAj82TGPfM2zCEbPK9yWF2m8FTOa4Mj9FE4HYj497NfwG7CDrO84RQzOo+JfQGQTXZ7LHARels69D5m1IEkN+CwNbiBSSOO3EfnSa+1YNQ/JFOyELltg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500205; c=relaxed/simple;
	bh=zBbAmUlliTRFsJm5cwbpy4/U7+PwP3S8I+lTALcCehA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaaJaR+5oPBvrCpb063u/Reinu6Aa0yLx4fCce5CwtvO+mWJe1DUdB2+vz9ijKssc9A0SHki3j1olnLv9vIYNfiAbEt4TzNVWZIlWupXiZ9Vc8b6JDo3RWejkGfNovv6JSpsFg8kQobKYx02ZtfevxNxLfS1Nx7pj/nWXxz3lkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/5cK4Rj; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba6ac358c8so2757eec.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:36:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500205; cv=none;
        d=google.com; s=arc-20240605;
        b=duwc+khrv1dydEBJK4KFLhei1xaC+t9Yc0MPmHOmsGz2B+BdOAA0EZROrmQpqkoRek
         6BeVmVXciGyy0ukYzzJqwNlKvNQZrdrC4/cUZqnJWBjwBe+E9cVRCFwmqdDyA2dqfx7J
         FNE+eRo5ciGamwNEhURHhftwclGQMLLwI4PU3zPQD+q3aW6eyS2BXPodCnRTeF/mfrBR
         jLQ+eiZwrU4DF6d6ajfJLLdi+PQbyzE9xkXhE6YMn9jwC696O08hCdQNokRTfqt1Eqc5
         wNiy1hfTyhXqlfZfy4+WZb9fhzc/tDf7oagmE1C7HvRPOUeiy6WJKQUK3DbxPjQedSTj
         J5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zBbAmUlliTRFsJm5cwbpy4/U7+PwP3S8I+lTALcCehA=;
        fh=L9kH6wNXF+cRWTd/rTik1jisGcTbwgtJnxsGjdAwMNQ=;
        b=HmzCV84JHBvHI+XNr3bg2xYMWMCfrYsnA+KfNb4kQvsYZz4vhCWOXg1FFX3SxYYpoj
         QWnHqb7BhS15WdbePOricQs+REMziJpAzZx/R8HLgbVAHhT2bH8krjh5PBIU8GV8Fwld
         2HpzC5PqfnBDSCViysI5xKnvceHdzBwUUMW6+k02Ca3N2KTjrQ5fjWz7CZbm5dzUb7La
         NJQYfy9bFS1gUnSR+L5aoEtU+KaT9L8LleroO94b1kLxNSpwizYBbeGgGVzveCCCIZdM
         /49LW30dEpQjQ6tcfGOoC4+/1nG9bI7L25TlmRWUQMR8Tx2Zo0iw/gOcx1BuUUbV/Xg6
         luKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500205; x=1771105005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBbAmUlliTRFsJm5cwbpy4/U7+PwP3S8I+lTALcCehA=;
        b=A/5cK4RjK7QgYEndD1i9FBkFBQGyTxXsqGgc8eH8K6Ee/APVXKPRE/t/AeaNsfrNqp
         rtwBTEGSTLmVE3rwELNj/C6N1hnny24CPqDuAYrx5on9+9X0ZuXXeOmHN+2fxYuQQpKN
         UKNeL0L+JBselpKC863xNdACcFhJVDZwzDqNKSbo2SWKgbTFLUcXFSpPQjkVM3wP8Wdk
         ZqxrBevABWzVgWC2o0EbzS+/1o1GLagt5hu3PKe5S9unnihyAi5Y05sYH3n5LJoI3V0Y
         sdvDJ/uz0ySe52rdfNESVfkr+xJt3YJl+mk4n9yVXZ6ZkET0gQoihwT4cQfHoVtZgC/C
         ielQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500205; x=1771105005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zBbAmUlliTRFsJm5cwbpy4/U7+PwP3S8I+lTALcCehA=;
        b=PB/Ts0MhyWyu5kn0b7b5sYKSAkOCjUJdL6Br7NMZaVHlJEnJhKr/4ZHMlr7DR+rldM
         DAgtUFzGNsnNNaP759tOh81cAJTWQA/pQviDUazKL31SnBuSIT7mUe9hReymRitgQXIV
         KrGmzd9UmADJyg0kiYbghF/QA7RSb2qec3MvNsz3Gnx3gpp7iYxIqQp5mFo0+FM1+UiR
         YlzT/7DmZB1aTWGx4t++KbquqlU1gdUzS+pfmSYeo4yGjuWR8pULDoDEzoOJyT4WnvCv
         dP112RFWaIx1exAvNEo9hL8p6Mcl0ky3/VrjKVyz0qbbJxMIzNfjK2XWWTdgLfzinWx0
         1Q1A==
X-Forwarded-Encrypted: i=1; AJvYcCXaz7Q1yLF7HO7xMLEkVIjf4351oFE6RdiBUhpUknmdlTkWVSJr8/6wjI2eozkeuehyL06Fhs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGSZX7E8ppFaOvl4d63LF0qjc0T+51PZIcEKhDLyFN4AEmzab2
	wehiEWEc4CFtCwA4Tfxat1CLUK6o706kdjb74RQ4bxHnbpl1MiAh7FsN4v+qOxxreUOSLJm1i2J
	JWbilRLppevxqdFGyTDDRg0kL5vpcX5irqNefgAtW
X-Gm-Gg: AZuq6aIqUR86PnBR7DMLjWR9GmFA7RLSRAEvGge7zr1nrridd7wOHORu/4i0gooNXqj
	GSNCVqSn+n/+mSaO/yb7AcRw3QmW6vpxZK/IPxcycYXfuvzc26JHf+0EtUeyk4q2++HGRuYBRl7
	eRrZDjtC7CwMu/ckuySgifpcqEhtDcPSesDTxtgV8gNznT8AIfZOUbGbJtfws0wZ2xQtTCVnwiR
	D86wM60iBnGGRamti8+86FXCeVsYerHVzuioJ6g7kAII4V0mzDkWnfzrESUos75Mhv7RptT0W/p
	WvzD0zlxyiiAruVBdKU7jy0f3lrwgoluyTK8aAX5LVX1SYXEHt4aYjs2YLcNkKMNoefoHg==
X-Received: by 2002:a05:7300:5726:b0:2b8:6709:2f32 with SMTP id
 5a478bee46e88-2b867094087mr1532462eec.19.1770500204517; Sat, 07 Feb 2026
 13:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-2-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:36:33 -0800
X-Gm-Features: AZwV_QgQJtAErggmg-O_Eu8gCi7nkeHGYI88Du6iJvoLSdq3SPcNmyuOOhnGwOM
Message-ID: <CAAVpQUB0U0HwkNCYDZVD2iJym7_=+kv3BHOVoyX4b=hSBfK_cg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/7] ipv6: add daddr/final storage in struct ipv6_pinfo
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257779-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B06941072B4
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> After commit b409a7f7176b ("ipv6: colocate inet6_cork in
> inet_cork_full") we have room in ipv6_pinfo to hold daddr/final
> in case they need to be populated in fl6_update_dst() calls.
>
> This will allow stack canary removal in IPv6 tx fast paths.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

