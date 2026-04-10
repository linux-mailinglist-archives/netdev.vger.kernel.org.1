Return-Path: <netdev+bounces-277263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JbyA2qW2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D33D2A97
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85DCA300A10B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826A359A8E;
	Fri, 10 Apr 2026 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iHMIr2hT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14B282F38
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801948; cv=pass; b=PCRuREWIa3GL1IYryzPDS9tpAe5dPbC3EQY+xwT58aF65MCbArNK5ebeYJXjGBUH0YI2J+2AeFvGwsbRh2kTrwIIxkjN02uvQV0mHUYzOMWI+WJtJKmzLT22xIWA7L48we5PVGujXWHqj2FUWYnO/6fgC6yT5pxieON1aD6w/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801948; c=relaxed/simple;
	bh=4Dr6sYNZceBCVgxbM6yHz0k1xaiduPlyLu0a0CKYOSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyTgX8CzmbISxYWFFdI9UMhy+ulAMwZxsrmti2xGUNrSWvq+aLMEFzeeGL6mfv1LfrK4w+bToZJ3v8b7jIzD/BQyBa12fjOIMGN5gue092q+dw+f5EXEOvl3DNxs+6xG7m0UlW3ty8T6b3Em6NtADCtUamwH+K/gUD/22FPsRJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iHMIr2hT; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2545785eec.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 23:19:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775801946; cv=none;
        d=google.com; s=arc-20240605;
        b=cl/79xuzqgOXTSFzxzCmi9PXPyU7GvfpXdKG1Pz1Eq4iqhWZNyVvJgopcD38HwWBEx
         fJB7kZh03TO2E7cuKVxEnLP9KiT93MfBTTPx+ta7wFS5Mm5e429rclz/WunvO4na8Q+3
         uszkqz4ed0xSpLas+O1XPRGC1Mp5HzoxOiA2YeWyaVAF23BXGNeKbI9GnTstRcFre+uh
         fIJb0k5jLOkdrz6q+iqjAdOOMfURZInVgHXFiU28S1Yhvq7NLOfRsoOo62wu9PeeBZ9D
         pbWl4iZH6derw8SZ+ldyK1Ezj2WDXzUyUy6fgBdAMFeSvM4HySS14QUphxEOsBGh6/HO
         VULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Dr6sYNZceBCVgxbM6yHz0k1xaiduPlyLu0a0CKYOSQ=;
        fh=ttsrwqxlwCq/LOK7fFcg7TSthohxL2m0thDHtX7EboM=;
        b=GUvPJpvsRRamPmTVXfFWAeqY6s9OkYCt1GfrkqCs5PiMwrXlOFU2oCqeL5s1a/W/r0
         f3c603wwgeXvsEm6o9IYh/FVjRWohLGvSP1QuhdOa90JH5ieMQYeQ6/XG1l1Z8x8NPXn
         aHco6bWyxX7GUi7Dx8/wVz941TtJUvqThArLvQTxuonOui8rzm4outlWoByU1llmA52D
         /sa+nSzVwlv6Z3w831S+GMro5wz6FNpEt6A65qxa8jKezz7XYCzsQ8kxrDj3JBunHtaW
         VOa9Wr+ENF82AlmiSOAnIY7veDQXVdqa5y05ic45XqdOn//8KPSt5M9SDIsL6IiPqATS
         tizw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775801946; x=1776406746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Dr6sYNZceBCVgxbM6yHz0k1xaiduPlyLu0a0CKYOSQ=;
        b=iHMIr2hTtNs8uP2DmAsVJFlensObWX/EWmlE20wp7Y6TOF/GKjZg1VMmpGR6YAKtR0
         aKEFOdZ/l5Fw5dTYQo3JZGfVPITjCwtmKMdKVrWz5g67lWnNR4nZXilRF1PsPSuk+8Lw
         0P95hk44l8SjUtyvixN1SsSufn8MicszCzI0F/6yw4HtLm52Z/tPplQEbNJX3YKaWcYW
         kNTUzAoCyGgDEKIkbSFZc+bEug9AJ5yuByv8gIkueJS8TNWA9igRV2FYH/aREBZrDSHX
         Nic6dg59o0oiHHWYX/rAVj/7BxclIH5acgQp1z+62QIKSYoEC4p8R2Q7DmTZywsm/U0b
         bjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775801946; x=1776406746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Dr6sYNZceBCVgxbM6yHz0k1xaiduPlyLu0a0CKYOSQ=;
        b=EfhDQdkQrvVXLb3geeXV5N1zQvNcVUu6XoM6LW+ZEHZVQBtg7KV+qLnfPdtjGPwUX4
         ksfQ8DJASI/GJKObu3nydSaJfFCZFNxGzl7c3T0cu8gVlzeg5/vuWSufKWk/4BWjRk4K
         53QH8BVdLVpVPBzmRhHrPN7rFRz9XSCmpdbivFA7OrotOfGF7Jdyy4ba7x6lK6Ylbjdx
         iStRGghScibG7HrIrdUVYtptIn0WDmFUl48PqbOV5lRvHZKg7inRaH7tGmN+9Sm7HW9h
         gpURLR9mSSs27rNWKJ4UGy4at0tVhSfuk+mi3UbVwSanTOA3ELYasx+ZuO7Cn0HGb5HZ
         DFWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjB50IDTj5dJum1rLSVrX1cLb2L9cenggrUkIcOH9hkbmZSNjeGYZAgF3LAoVuGuW7jJRYPlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzejZopEuawa24/QjJI1bas0FwHa/C8SJkh3C+2XrlFG8zAJu2F
	3S1Su8HwemhM+Q7VVeZ3uNIYtwYhUnKA7DUn2Twb6BiLwdHmEadZqAARJG2AsTYPWdIakb6X6BB
	X5JmOUtjIqYblMV9dsjOybFG3lBK30BjfbKhqRiNa
X-Gm-Gg: AeBDiesABVr6bSxxp+o1h9FJE7BujxQea05UAUHBlPaQGPQ2B4s9q+tAkvtU3Ld8HXb
	jf6JEp6HaWL1lFS1L0OIjQHAF6kVyQNYAIwxQ7PUV6Ccc7ixB3ZzWqjjwGS42gq+QMaAKU81eHP
	QmkqD0t+5eaQyNhLvEKwoa7s+ZdUae45hquwhMokOrH4KfAKbaGMHnEgj4ESFojTDv9HQcY5x2z
	jCjXeQs2rr4XX7S0Sd03av4xmn5go0CtwwFq4TuUzmrlAfWiS+/RbWlvRyl+UaU7/xLKPh/OY/X
	1noe9Gw0N3G1VlECgYYdGIrWIk5vV0zRf0N1Ii6wf1vhWgvOeI+H1PNEPC8QGmbrRM4je21j7zn
	eIrz60LY=
X-Received: by 2002:a05:7022:6982:b0:12a:7181:2f1a with SMTP id
 a92af1059eb24-12c34e6913amr1222598c88.5.1775801945276; Thu, 09 Apr 2026
 23:19:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-5-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-5-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 23:18:53 -0700
X-Gm-Features: AQROBzBRPpJZPgQjpBAv368-aREu6smb9ZCYu5m57L8QwgeDzwSfvGQkv9qZv94
Message-ID: <CAAVpQUBvXC9TfmZOSNc-+aBBQVxJMw9q48Hchgumrp5FK2g8+g@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] selftests: net: Add test for enablement
 of ports with teamd
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277263-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 836D33D2A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> There are no tests that verify enablement and disablement of team driver
> ports with teamd. This should work even with changes to the enablement
> option, so it is important to test.
>
> This test sets up an active-backup network configuration across two
> network namespaces, and tries to send traffic while changing which
> link is the active one.
>
> Also increase the team test timeout to 300 seconds, because gracefully
> killing teamd can take 30 seconds for each instance.
>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

