Return-Path: <netdev+bounces-260774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJIVHeOWnmnXWQQAu9opvQ
	(envelope-from <netdev+bounces-260774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:29:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 367571925E4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 07:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 828573079E2B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499392F9D83;
	Wed, 25 Feb 2026 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8mV8kiu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84D1ADC97
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 06:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772000987; cv=pass; b=rjwlubgA1CBY5zMSjqinEHf11uY6bDEGp5CeVaEPztzj3dtJKGIe1TYInThZqSr4WwQ5fMxK4fEBT7hJjsh/IfTf319Z/yYPgHITTZKrgOWOOYDbMvFE4Qs7W1sM4/6miEoOTz2X0Tgh0hBUK/6+GJHhY+F6Kpha6vSZyxqp/0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772000987; c=relaxed/simple;
	bh=1H7ASAjpXSVpzxeNA58qJZFYrDFjKuuqkVSdPHj5ugw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSDii8mJ99f1spI1m14hloVwTRvXyF07PhFilLLAGJbstNznjnOW7bslFmXs4eD9GAuDyecJ25sf2kUlRavteFx/ysAeQobXcwguw2SYpWQjZsAgFQthn1WE3mFLK837c+Lhax8jWIyJXLvEXdejuZMJ6WZ0zXz4UFjjfv0FTxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8mV8kiu; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ba88e53b46so285892eec.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 22:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772000985; cv=none;
        d=google.com; s=arc-20240605;
        b=bawfFfXDl+26oqaW6Ixfku5mCRW+9aTvhHA6exMZ8gRLG32ZMA2xoh92YE6cR/VOV6
         rZD1Xx0rSgw+kVOz29aT8u1GZUI1I7vdek314WHc5rCt/oC/DiJjGaTbVj3ltHKE89Cg
         Uu1gpsQ/Pz6XZ6l2oRGZkAqp+ye/5YHPUOe8cNxp3A+5GpWqMrY5wzNz3ka6G+pJJ/S0
         6+uuIdi7QYAAfn/gk2MC7RaOR6o7YG8JHRNZ4RbtvsODkb3X94inSPoMhjjI+0nCD/Au
         7p3Y0qnTTT+MhqAD2bUhqZFL+b8RKeAAEAI2O6kSF5auXSeckILeecM0l4AajzOSDJXO
         OaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1H7ASAjpXSVpzxeNA58qJZFYrDFjKuuqkVSdPHj5ugw=;
        fh=okYOmo3LZzkiZCuW53LMq/KLadzSTr7Gtq/AiKyB63c=;
        b=edyAe8mvT89yk5bY2fEwxJnVOFkoBkVjMLg7FJsfAQvBAqNsfe6P3r+8IHGniiqRBK
         Ci/vOXoMmiXdK73Y3IYSW1WGjOU/pSZrSN31Ev82qy0ngZLewH0D7YpNsrdP8wP4hjd1
         QBagVuoDk7Fji4sZPtc9jHs9Nh4TjN7lbT9738quNDUTOBZR3jSiOk7FvU91HAP+PvTP
         AuWrFsu9NZsrCCe983yk95uCsO04EU0P5XER9K3AdEB0jMt9bvViaZT1Jncsd/D8JoLQ
         VhEavNWPGY2fzTLYUdXgjgrpHJGiimy83JiRIcXpmVWfbVNYwWvu/jyCCKRelnWLCi2J
         L4gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772000985; x=1772605785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H7ASAjpXSVpzxeNA58qJZFYrDFjKuuqkVSdPHj5ugw=;
        b=r8mV8kiuczfO/B9vtIAeYNPNvsUP1ko3nihJsUafJPo6lsM+BtgaZ4Q9fRc4GXsQsB
         6PzB2X91CQiTdQvo0lrYJlQaF+QC2dlUlSLv7e7q9YZyFWgWLIdpljvC7b7JRRqxHViH
         ioqaqsLMHNq7iAZs6FaH6Hbhoqgw8eTHipAJvn0QMQxktpToHCMQOgcWb9prRknpiHbW
         MaJEiC0oDKFrIzzTkno0uNoUPWM88urbxHLRwyfzIsh6m7zrdl0AVZ0ndHjfB08Vs87Q
         bj/hJ30vg41FpZOagpiatWCcGpIPjg7Pw7UsR8zPuVG65b5nCtM55c8IwrzT4PLYZ3j4
         Ppew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772000985; x=1772605785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1H7ASAjpXSVpzxeNA58qJZFYrDFjKuuqkVSdPHj5ugw=;
        b=F5fcGhc4EnxL3pxuhUTWrs2qGoF6wpNLz0dagFkx8LXkqFhWXxv6tVmzabz+yM40jK
         FaDFkEQ2YRgrM03UaaBow82dquqtdMxsMsfq576+2mXtk/VuRDQBWibioxMWma+/O1wa
         ItzMApr6ynU+G7HTWbS2Nw8sKwzQYfZGW4WWQwMWT+PANdXWmL6fdvKzTqwmYlR7ea/P
         a1I1la3uGbKG2vJVtwMfdf3VAyl41g2SSqOfRnHmVxHOLoWHFDDr7hRuRbpZH0uzKX51
         hFQ5I2BvmrDCrqSiO4zcxMfs51SrcmQHirxgr/NBlLhMipY/T8U6adbxMfP/mEiPqC2k
         zD2A==
X-Forwarded-Encrypted: i=1; AJvYcCXv5kXu1SPhwOjQdNBEIrLfC5k/bFxe34L2lCufgpHkFCBIZTdhBRzXpznnCEm5kxwOcfIUCMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNhU3CdLbeSsZmiX7KUFTKXf2+lXD0gAmm8HiLcnNex3Cz/Dz
	/Y9KSu4aUxebwST+SMEpaWcbERt2DTulf5AJNUmnq+ou/WkIv16JiTg4bmfyNHj5JhBcaG0hLjO
	yglMGEMle8K9hMubtu5i34Xj3nqOArnlZ595NfaOP
X-Gm-Gg: ATEYQzxEwAk55bLuKypNJgi6VptGaY9NwNx3BswP6OsCck7viXHvM75Iz9D7GZ47s4n
	AcxRu1fhRk9JDo+zC2G5miVwVqf6dF+70eMqB7RxOUlSRLVZ1BSUDbTf5hD04LbIr2G5DOXiHU8
	74GPipuxyWkME+qrzw11su/9VuvOFQcp64YNt8Rz0jlx6bEpY8JvzVXZ5kIPxTKxYQEv1LjwBHH
	JvMeXKHyWO211MTRQRpc93YLivbO22kzAPPcePlPC5PhGWNa+j13vp0dOHOPbhtADhxKqMys24/
	yyU9lvWWry5NQDQY4gkuV1KK/9nEJI2g0zQBnTlmV+nKP4iAE+gE4P3tAqiiV/Ze2OyXg67W
X-Received: by 2002:a05:7300:ed0a:b0:2bd:ab6e:5d3c with SMTP id
 5a478bee46e88-2bdbc508971mr901962eec.12.1772000984188; Tue, 24 Feb 2026
 22:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224-fix_zero_wnd_fin-v2-0-a16677ea7cea@gmail.com> <20260224-fix_zero_wnd_fin-v2-1-a16677ea7cea@gmail.com>
In-Reply-To: <20260224-fix_zero_wnd_fin-v2-1-a16677ea7cea@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 24 Feb 2026 22:29:33 -0800
X-Gm-Features: AaiRm50BS8IRmaByvMXoPdLT4KNzqIZ4frqt43YdVqbn5w-X7rkkO6gZU6lK_6U
Message-ID: <CAAVpQUC-7hWiefYDsubJTMJP0hAc1pYFQM+p1LA3NJeG7=ebVw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: re-enable acceptance of FIN packets when
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260774-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 367571925E4
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 12:20=E2=80=AFAM Simon Baatz via B4 Relay
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

