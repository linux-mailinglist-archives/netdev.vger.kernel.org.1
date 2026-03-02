Return-Path: <netdev+bounces-262917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P1NFgYOpmmFJgAAu9opvQ
	(envelope-from <netdev+bounces-262917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:24:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D43AF1E54A2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 23:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBD1F3143947
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 21:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710C3909B9;
	Mon,  2 Mar 2026 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0WDP3dl7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C421A680E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488082; cv=pass; b=I+iEeBhSfiqP9FGVJVNWdEmAPcFzAp150ug2o8UyRhl9xBdZ8D/7vjBTN1oViddkdzQFRyvvrFBgluoTB8CgLUJhrZb59C6PPQ1EW11nqlVlFJfhRVSKAqqwTcNImA1AoAwd50VWhnrng4hy9su+EKCoop8RNJljhU3df0KIxEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488082; c=relaxed/simple;
	bh=feHI6NH1LtpEWw/0IGOd0agJUbY2/UVXbUUM0cOZbjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+Hw0flsjap5biyRpzcMv9rU0TI8ZJcSSTYuDOXUQc6sWTceUHOCsWidELtVtzFDFjbmwrOGwT0dqw+XNmVfhWhqFnfojFFK2p1Du88XCYcCJkO5yYw+EIH1JN6APx4YD31bVCDJJ5eJpg7RqOZ+XFQLmgOWOJtbKR6PC+3IIww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0WDP3dl7; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-127380532eeso1856702c88.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 13:48:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772488080; cv=none;
        d=google.com; s=arc-20240605;
        b=iZX6bVlD5gF9qTEk67RqdtXE+brXv3+PZ1pqSFdXjNmGvkYVQvForvwOX40HvTuKmo
         aoTOBJm0FY8jBEh6GMIpf9BtvA86LACFtQLakSHKs8+FmaltVhKxGTIv1deQ2SNJy3eh
         g3gsPlx8rnk/GufI6GmeKOz0iL9buiOb8+oUhEiQQk9p5RY+DjM/CyEwm2b/rhxpL8oR
         08AMcTRc9wEt/bw945C1nA3QeXq8QMlsSevQyj8ByRemGSN1nAR1H1W4gkG7DjviF8UP
         bprnT4xumNbxUips8Qn/1fGzpZxaTyinAju8PspTZnlqnRaxu58bKiCjokjSpiudbV0O
         Uc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=feHI6NH1LtpEWw/0IGOd0agJUbY2/UVXbUUM0cOZbjQ=;
        fh=HE+yhFJcgTFzUebC+D9PX1qumIIBaMQZ8lar4KJRvkw=;
        b=emxXp0svv9iOBEmT6C007OlQvdGxHiYVw3ly0jlLagiwAt4Xg+AiGaq9TiSHVWIxdY
         tTkhUByqGOrLM02voPH1uf9MMaXDpi1MPJ5Q5L5xZUheqnUk6oIIoFGTHwk43MaebxWT
         YVCMOHQ7tFA2JtMJRsItwTWuyi1C3gadBZxF/23TltbINj6I5MsQprxQroDkz/YRO6AH
         ZdLRbp2A935o8PKUBe51tnupvipkUeUmd0qLU9w17gEGxAQ62cmPgUq4FF3KAcjlbauO
         aV9xslw3T7v8+e/r6YnKCNpcg8txZaLMNwyCaoysJWpIiSJnwaxa8y7fSsNFmWI3HtUx
         bVBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772488080; x=1773092880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feHI6NH1LtpEWw/0IGOd0agJUbY2/UVXbUUM0cOZbjQ=;
        b=0WDP3dl7YFu4K/KO4gDuPROxmLrWRxPO8rJGDuJ0R8q+b/aFBmVL6xqI4LJJ8mWZED
         EFgKdfl5cryxt7cJbDkdTmJHRgyS2nasvrDR1Cy/gLqD4UzRdmhpuH+cgzWrfbX738fn
         GnLWnkDqpyVj9WeeLA5v1XFnwj1gYB3yAg3Bx4CoseTlgBrFMz/zgoInbP8JEg8y6+Rk
         vRdRf8n93bWrzwX09vY2rPWgoweXFgUpFrM0p12/+koz/3bJQiMEYQjaYl2NeMLODtE9
         3u7+TtwXJeA1RrVU/JInJESI67m4bhRufKFQx7y02I6d4VWUYrd7lPc8z+svFC7eyxwB
         GtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488080; x=1773092880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feHI6NH1LtpEWw/0IGOd0agJUbY2/UVXbUUM0cOZbjQ=;
        b=O9Kf5tjL5iGecJjULXoBBr+b4dcrV9wBsx6NIeq7MuqlxMHMly9XwmProISsxu7p0r
         jGyIg/6d6KNO7kK2AAVOMbQg/BFo4jBiwx0L5J31fqKtL36D2Ux8E3QqRKBeSbJuhEWe
         Tgr66QTPl9fOsOu2e5gt46H/9pWXKsv2ohSehr4wy+fzpFRc3bMb0yU3yWQHjuBo4kZZ
         mD1Y5dlsOEcIPbMhlBryYML2YxtIy/uX9TQvmbwRvF/bUy23Fd2OAaj7maDKyToLhkzy
         QHVFQP/94wLIbmJFxtAKHDveCchochEpY98H9/Jd605lP6gXwv+YIaYmzo1ZnZIybzk3
         XSLA==
X-Forwarded-Encrypted: i=1; AJvYcCXec1CgT+vu9qSVmkbevGaLZTes2Rst5cLKUgWDKPonIyeSma95jKZaH63qyOqxpibEAEIq/04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQCRCHoFrq0wHgCigkWtHN9ryPT1FPdDzu7xPaImIyURU2070
	BLqfWU/C8WIPJmE3hJLQXrhxMMXGUJGtnP3MTVH0FXuUFNM10njQwZX0GSwp+BBQN98bgMYOBD7
	EjW/R0Vw5bWJ9tF9WRhp3FBZ4tq9RlAjd9Z+V6yWJ
X-Gm-Gg: ATEYQzx8DebqDuHOcROme3TiMqGYMZ48R8Wc+1UA4jdCBnz5H/2+eIGxo91nnb3DWIZ
	YzXdaOpYaVvsn+awzF1G8mCqvJnsvIfrGcldnOA9RWIjtU+FuxCtjQB4pCzs8W+6IkK59ktky7t
	Ig1rK0aTQ0KY31JZIqi08ZJJw1VfAOWAMzJEmlDWSRMkodNnBJbNU9RL3mEqyf8g219jboE8r63
	5IG8XbgaxCPm2joC3PiwETr2+9tzwR20rBNzY8qUEW4/w0R/qZ0W4mb8JqkNtywg8d7JMiEqz6Q
	+IYIAPRtADWMX5mToSLO52Q1tEg9yygkS0NEwmxH/9El/cazkPpxnsMMBfWVc9H900de/ns=
X-Received: by 2002:a05:7022:e02:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-1278fd1318emr5946869c88.32.1772488079645; Mon, 02 Mar 2026
 13:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302205527.1982836-1-edumazet@google.com>
In-Reply-To: <20260302205527.1982836-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 2 Mar 2026 13:47:48 -0800
X-Gm-Features: AaiRm538wos0Ww1dNiBmZD0E8P7t9GdSBNNRZcMBSW-jLZHhNJnkHgOXS945_oc
Message-ID: <CAAVpQUDFV6PxGu=yCDXRrpC5RGBFG-QNtw7LUX03jx+Vi-S-Fg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: secure_seq: add back ports to TS offset
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willy Tarreau <w@1wt.eu>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Zhouyan Deng <dengzhouyan_nwpu@163.com>, 
	Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D43AF1E54A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,1wt.eu,vger.kernel.org,gmail.com,163.com,strlen.de];
	TAGGED_FROM(0.00)[bounces-262917-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 12:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This reverts 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp o=
ffsets")
>
> tcp_tw_recycle went away in 2017.
>
> Zhouyan Deng reported off-path TCP source port leakage via
> SYN cookie side-channel that can be fixed in multiple ways.
>
> One of them is to bring back TCP ports in TS offset randomization.
>
> As a bonus, we perform a single siphash() computation
> to provide both an ISN and a TS offset.
>
> Fixes: 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets=
")
> Reported-by: Zhouyan Deng <dengzhouyan_nwpu@163.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

