Return-Path: <netdev+bounces-259921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 23FJGzSvm2mi4gMAu9opvQ
	(envelope-from <netdev+bounces-259921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:36:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C9171560
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 671FF301A509
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F172C11E8;
	Mon, 23 Feb 2026 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLAqY7ZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CA2BE7DC
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771810608; cv=pass; b=aTJj9YswtGAnQH5mG0FqyrLrSu0YcCGcseXWAfVANlzW2G6MOb1+RQjp5PXdOXqShIiweDWNwXPcKCkTw8ssfPvhQf7phAkX9KpORO2Se1KnPPfks6dNcUaxCCVu/V7j0QF/UH1eK4Q2VV6FIs6FekmTChvA1z1pY1jpq65a8Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771810608; c=relaxed/simple;
	bh=56807nNBqcnG8caOg4si5mazv6USZKC5wC1JXqZVBco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WwR0a+J36t2w70INlt6OGeaQ6+B6hhA4FgvfnOY9Ujsdtcm9Okub8npa4aNhKKPIW6wPMnbRl2FPvkvn1jt6KmSD8TGkj7N0aW6C9rWk3RqjV4uMxohPG2r6vtU2LYptnteD2gxveVpS9E1IiFHa1CG9NQJWRM4h71iZrhS0R74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLAqY7ZG; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1275910b930so2775432c88.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:36:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771810605; cv=none;
        d=google.com; s=arc-20240605;
        b=gjSg3ZUySzPxpdamt6ZKma5BgTjywD3JBaCEg1wNM917PrkbFtytcFO64EDTOjN4Ou
         sZ3YevnMbvzZrLKMAFZiYWOO3BgZPAyCAEBUE21XpIb5Wuwmqddq7lCJ36yfMCbqR5U3
         NkYqPlcLMFVgJA6fulvSSylcNUrw28QfrlcKPgJ6lvi0OFPuqu7sZ9Vn6yBiX0N0TCFT
         eoY5M2uTot4aMbxU/kE+QQfIi/YrZ1JIQ24vzAHXwzmTk8fKttexG5r+76N1VHbcCl51
         aVmkk/5eR8rdL0MpzUuTds6BQG0Eku2P1pxIobiKs5cQEcuiRuves/OZLAjgFej1+xjW
         sGFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56807nNBqcnG8caOg4si5mazv6USZKC5wC1JXqZVBco=;
        fh=EYS8hWnwAjWCLwETllJO2XlcNWQOfFj9BEJJchskNQw=;
        b=Kt6sRRFmmAe8Ett8i/77G6A57QETdCezRtsnvsM+7gfHg8fvXmxN2/Az/C+5YFbVOw
         vhu2i1s+XNKI22STc4AExwzw000kgcDcuRHAAduLnLi0yNrhPkIt9gV4vNKd7btiROJN
         CvzTMJvA0LLQgDDU0LTQwSB4hYV9gjbO6kry2cxcQhIT3QJ1PwreJOcRsyIzZMFMDzip
         BTdYUFmKehFUBwKh3a6QKCbVlVOLI0mg5YQqI/rNwhHQR/nqUvskRhHv3dC83d83ctKG
         9oks45bx/nTMFvKORqYu5HdT889ND+HJIe2kkOHapx+1sil+3TM8TZJ+qk6gSt8S9Gck
         AO2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771810605; x=1772415405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56807nNBqcnG8caOg4si5mazv6USZKC5wC1JXqZVBco=;
        b=HLAqY7ZGrI2jJ3KOj0NUwkgeRXd365y/HZodkpDEMXkE9nUvJr954YvUP6DUt9CLmY
         xUEmkYAlJS+7gOwhHQttcO3ajIef9xtagrUh9bhKFvIE53Ieev2eMzuK61Gj4dEQrCVD
         4B0bc/HX8GVnpzZEjCsjvl0zfbJJ6y5iZGx/qCVx3BoqC4bPULTwrrbjDMm6QaGKg9dc
         JhTrJCHeD09hMUIzeH8G2XA4K3j0V1RgHJy20/esTV1bSjVbdtYQje3UR2GqDrTmalQM
         y91mIP5bkztgjVBv236Pe5QBQ3QLtgjrLDAw0fPlu9cY+0T3K0EGs9riG4Qd8+qYmEFV
         K5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771810605; x=1772415405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56807nNBqcnG8caOg4si5mazv6USZKC5wC1JXqZVBco=;
        b=gqeSePq0XVXSl4kgYoOPNKtkcQkrEeNQ0qSz2O6m2dJ3CdChvIlLgs2PKnV0aIyUN8
         yNv1k+YwddAk/n/h8yte8HQEOIOZIXaKqdPmdrhySQDx8tJ0FIX8/9OpGwHFkZBEb3DY
         QTmX+mQN5o02+FU7Q0uyEcw5pBmtpLLmtLAMpi/Yv2Nbm0Aw6Gs6pWlUXM7AAAYi3TPn
         4S3S957qHQRdnf+VzNsh7i/tXCP79pbSol/U8tdQo2cGcwOymHolMuqMoo2x/WAyaDUS
         GXHXAQRVlebqhzYLLLE+tE5XY0qeQn/qziY82qyGl9OXD5Bw10WjjHWD28lW9yZgDdoR
         E1+g==
X-Forwarded-Encrypted: i=1; AJvYcCXX54cvuIpqiabAsno8pMqm6pG5hRkbdRbUV/asskasW/VRp86fXIU06YV8hMywRbVolqp0DLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgmLYg5wkS9N4VkWpC6qSfbZ2/Oe70iMK2S0FcbeJkk03BZJlQ
	rMCz8ZJFVXIGsNJvLHAvRs0lISx/9EV8iCyyMReSY6+mJQp+jPutytY9CSnIHFAPLkBCtXsagDi
	yFkGlUdV6sSyqgPqAoDwGkxWcd0tm3yz6hFMsBvuc
X-Gm-Gg: AZuq6aKKJrSwNcuFt/DSG9bvJzUy4E7eycwPUWMMZ5iFEAORJvf6kCdxUQTn9SNpam+
	ra0LOIW1utiGo5lsCJM+HKZNuVua7KQrdOh7eca3fB1IDAyIgqMGfM826A7vW7RTjsVNVhtx9r6
	oP4a0XTqvYIeUY2PC+rlWffg+G1fhei6Cv6v2NJ0nkL3u32Jyq/kIMch5ITGQtM61ysyHjb3V19
	MrrccFb8xNLId8VeeoJYmH1dcAc3UPxS9jd6zdRsVfedGdvRZme1HUxbGsXyPx1gxlVmXbAAXRL
	wd5iYBAKZztaFrFITVfaGaK1fv0W1jJPs8m79zWYgWqkoEfCgYF2sqOhkbcmPb9CsBMlsl8n
X-Received: by 2002:a05:7022:210:b0:11e:3e9:3e92 with SMTP id
 a92af1059eb24-1275fab7499mr4383996c88.23.1771810605061; Sun, 22 Feb 2026
 17:36:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com> <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
In-Reply-To: <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 22 Feb 2026 17:36:33 -0800
X-Gm-Features: AaiRm50qMcdmSp1awvPNwQmaqwcUe7gupisvQyzMI5Tf_UWIEyQFIUbhjca6eWM
Message-ID: <CAAVpQUCYk+eNb2oFVEzob9bh8Th39wqdxD5b-L7AzO9cueCOxg@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
To: gmbnomis@gmail.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259921-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CF4C9171560
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 4:35=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Commit 2bd99aef1b19 ("tcp: accept bare FIN packets under memory
> pressure") allowed accepting FIN packets in tcp_data_queue() even when
> the receive window was closed, to prevent ACK/FIN loops with broken
> clients.
>
> Such a FIN packet is in sequence, but because the FIN consumes a
> sequence number, it extends beyond the window. Before commit
> 9ca48d616ed7 ("tcp: do not accept packets beyond window"),
> tcp_sequence() only required the seq to be within the window. After
> that change, the entire packet (including the FIN) must fit within the
> window. As a result, such FIN packets are now dropped and the handling
> path is no longer reached.
>
> Be more lenient by not counting the sequence number consumed by the
> FIN when calling tcp_sequence(), restoring the previous behavior for
> cases where only the FIN extends beyond the window.
>
> Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Good catch, thanks !

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

