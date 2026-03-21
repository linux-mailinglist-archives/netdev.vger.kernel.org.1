Return-Path: <netdev+bounces-270213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHhwNPigvmnoUgMAu9opvQ
	(envelope-from <netdev+bounces-270213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA82E5992
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 14:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE604300A130
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73651326941;
	Sat, 21 Mar 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ybm/FzIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E50730F819
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774100668; cv=pass; b=JZbiRALAexLhP/1+5KrxGNTuh0kX10M0npqjkgTMwNwEVu0TszNSVMw6lXeinfflBZBztvno1Bnhl6sxHN/I9H+yW1LuD+YIcYHD0t91T5yukn/dte42UI3VBrZenrQtMfmz8p0WWGNokbV24YFvzyN7lpTR03p8Eg2ZTyYQf2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774100668; c=relaxed/simple;
	bh=UWOteceHCS3QumoPXPj7uLSx8YjZBJL8ZVSYUmQFpkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO/U3+5D0eYgsvul6mr+SZ+krilO1si+O6c8UUzecTf7IFiPw5WyV2TYnhKLr/bHwzunMnQ1J1e9EJAzr4Uq0mPs0w18k51mD3yC5ZTbLojKjfKdX8fzp36SjQXr7FPNWFbSf89Gq2xh6VCO5TYmWD0ZI3JJsFzjImIAKlZGRqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ybm/FzIt; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-127380532eeso2141065c88.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 06:44:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774100666; cv=none;
        d=google.com; s=arc-20240605;
        b=k1qP7QEEB17ckK95a/e4Ukj9ChlsJZYVrv4I3SXgTrys2bAqbrTaFiuBEZJ5IIJBIY
         yJYMWX1bKVMpTiiRuwA94lQJmg2WbZRKzEtBS9APKBYD0qr4fGwpNdiqJX31AmFdUC/c
         z2CTjbDr+bs/ysqZzh/EQqefDok9QXqhYA9aG6F8qCy0FENAcvsEnbce1tD1aBA67Iv1
         UlNeZOkzi4KfuDnGLx09KX63zXKFWU+nrdfcwIdfb3IT1sU46XeT6dNlV25L078e6P1c
         9LG/W0cHFTclyG7F/UDhf9dbS6oz+Ac8FrN0VCw7p53j7Ee3WSJZN+S1kolgrRjcWhad
         Z4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UWOteceHCS3QumoPXPj7uLSx8YjZBJL8ZVSYUmQFpkU=;
        fh=LiIb8G1UeMmc0IPjmwoVT0LKVYsG+3haoKLQ1In0sBI=;
        b=aWSKhR43UoFE2fQcyNX2V5X3inwk+18tPSukbR0cIjVvSChqE7FvZWlP7XQE03YCrc
         7odPMBalIe+WxFtU5OjH7i//QXyJ6kQOgrtshx8+S7nAtpcNqLdc4X22++tS2ocZMuZy
         4J3bAqqTDmvDWYPEfJhFB+BjEeXwdJBsq5u7U2vrI0E+B6k8kc3eaWhYHVtL2Mgpzkcy
         ZDkdIsETrUdq6CO2cFJOPYeakNuD+Gv2lGUTjHSY8F4rag/AWGYm1osBxfhLvoQCvcXy
         zOiFYh5mzQvgJgBtl00bPql0FgeXuRLFFhZHLavfHcw95nH+aAQ4/ktpL7abBpacdDmd
         7LBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774100666; x=1774705466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWOteceHCS3QumoPXPj7uLSx8YjZBJL8ZVSYUmQFpkU=;
        b=Ybm/FzIteRbZdg25nUdgKleQMxQDg4P2qs7ajbbcDki/q68ihwUgcz6CbN6sa64h7R
         AB+pzV5T7PdsMYxujE+rMePC3hMAlgYRcHHqHTxVUwr1GZjHZa0Ae00hIf6S864V1uaZ
         VxdHvlb61OuDyJZefXvnOllrMe31RAaJM8xl42urW/0ZpoilnkhDH2fcU1Tj4h7xIMF0
         A+s1OUW2b9YGxzb5OwAYBFHJctzLvbFNKQNsWblub4qjqktN+zr/zGbqPuv+bKzYl1Aa
         6vaf1l+KqAl7/6v8h2Ih7fkHT1xkkaIq4cLERhGNxZA75MoHqWwL1SLQ3vkFvZBuTxdJ
         hpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774100666; x=1774705466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWOteceHCS3QumoPXPj7uLSx8YjZBJL8ZVSYUmQFpkU=;
        b=N7D+RU+HjjFaOUmAnvPASToMAi0zYhMuLlcYQxJwLtm9yBJYSFAzaPeeZmRgBhwYTH
         MLYur02Tdauhbpeoz5AIXecUvZgCTK2x7FQsiKV5qEeCO83GxmU6Jdb0rX5e07cHgv5Q
         mS32Kdg8iOFIFZD0/zKXY5M2Ndjbfbed2+YjLfJn66aUAVhqrze6F5VI5/QBQRNLA7/v
         CJLK7pvH8D2z1yvqGR9HKEayjMwXjzRhDP9aeRpey75PAK6BCh84GY2LnkGM+kyDMeU9
         ApFiW2tLPk41HCC5FeA1aiCRkYoxgI58miB+WTNC9M6oDr+Cj0UhF+dswMtPSlWFyILT
         3jGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVObbSNflWRQR572NO+91IWTGLxak59oJSrgBzAzUDs7hhf98ebBXnKqRahMSooVGUdbMG79Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7vDLPcjuWIrOfG2ZhyqdvdxHhvfMtXIWB/Ad190UmnbMR1Xiw
	BRFy5WhdTotbfl4YhNm+BW1ImHiyGiPejtPxr9emohtasZzfbVcS7Kf1juQz2wxwG7/5Qo/61Or
	7UvRncMtFWODNnckSANZ5WSTbkwJtATAa5p9yYAImsLBsen6LCWEALz3rv1Iu0A==
X-Gm-Gg: ATEYQzwFcW3wUTjmrL57LJD1R/VOAw/pgbsh4rhIcWGxHD0knj41++KEHxYMBN2jM9R
	HyXsKAMBiajauVkhG9tA3GExvwR38qCR7xzJni294pXg4PASbG7Jl/l0NQpgVGF1daz400o6l/L
	6HQrJEADC89KaymyCOaPb8p/zqDJc3jhrTGN86MuBaR7OyBjKXkMVJLMraGPPOzGOTWsxNKLeiv
	lU61y4o+NfsCJ4rLFuvbLWxt4wzTZJpJ18xK6u705Qyf3ANYXFjr7Gp7vbd+PldunQnQO18IEj5
	/HaR9QMfT+6GVvRlDNyDEJS6PMtK/MZpI6JSZWI=
X-Received: by 2002:a05:7023:b82:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-12a726572bcmr3221490c88.9.1774100665707; Sat, 21 Mar 2026
 06:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319181817.1901357-1-martin.lau@linux.dev>
 <CAAVpQUA2JhaewkprZHccQQu20XgnHmMgZ_q6AZWCP-V+e_YS4A@mail.gmail.com> <20260320175900.0a7801bb@kernel.org>
In-Reply-To: <20260320175900.0a7801bb@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 21 Mar 2026 06:44:14 -0700
X-Gm-Features: AaiRm500QMks-IEuW-nsZqz2NwXlCI33wmxR13yq2_7xs09ZiZCNEokthdv2PKA
Message-ID: <CAAVpQUDr1tNv1ocdReE1FwygCiCHDw3SDWbQjEUOk1-1d71BwA@mail.gmail.com>
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using hash2
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Onyshchuk <oandrew@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270213-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 57CA82E5992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 5:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 20 Mar 2026 16:07:10 -0700 Kuniyuki Iwashima wrote:
> > Confirmed this fixes the buggy scenario, thanks !
>
> Should we start a selftest for UDP wildcard bind behavior
> or extend bind_wildcard.c or it's odd to ask for it now?

Makes sense.

I simply changed s/SOCK_STREAM/SOCK_DGRAM/ in
bind_wildcard.c and all tests passed.

But, this issue requires UDP-specifc setup and test, so it
will need its own FIXTURE and test cases (IPv4 & IPv6).

