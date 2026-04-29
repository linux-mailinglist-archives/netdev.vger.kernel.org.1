Return-Path: <netdev+bounces-282151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDzJDZVN8WlRfwEAu9opvQ
	(envelope-from <netdev+bounces-282151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:15:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC6348DB96
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9C59300D46C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CD1632E7;
	Wed, 29 Apr 2026 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XouY6cdB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFED87E792
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777421703; cv=pass; b=HZfNbCxpcM8m+Hx3ghgE37HWjvUSz9E50xXW5ILHoO32dS030jCvLVho1HPrtKehrmthxuBNa5oIngf6aT1BRxSYRyFv81WENmprzrFxkzhdZ3G27WX3Ftu9bog1r5zhZ8lvOqFy7Y93kKyi65gG8ZcNRUBv2qFX5IjwTBMuRZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777421703; c=relaxed/simple;
	bh=69RqotLGaHA+82ydaZexv7veZoHxIQWTY3fS43Pw+Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8lIVYIIK0TW83mwPUTmMrL66OBOlW9J7PRKqwJY/hBlMUVxALeRGEAlIhXTF0L2Kmw3uznqzbQmf8S7XznrJvSxjNqbUWwev4aXlAafZfr7EiutSwSTqwGBUs5ayi1fpAOtYOG/xrFfA3amr6V94d+LVD8oHUIfEsd26TJmM+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XouY6cdB; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d75bfb259so86797491cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777421701; cv=none;
        d=google.com; s=arc-20240605;
        b=aljYf9NNZ4aEM0RfgYoNBiPQzDTyulwn/9k+jxWOG9CTWPzGzlvriOfi3uj6l/i2Ze
         V4KRyKHEEGp2cm8bNg0cacZsO5u+xQ5k3ZHoB2+ZToAJ2svhdkszfWiQdxxYFRZlMK/w
         9h5/qcIVr4LcUn0CMSTB5vD55bmYhS+fPiGifM4aIpqYrBehfxE0qI9etkhot3t439Df
         Ii8Ge93JjL/W5HKsLAFemd6zHGG1AnRgFb9zIYdY3IoH8WLbEOShdArmT/hwibPeClCx
         S4eM9kurGj/G4b4+1+fLiI7JDZeys8FfOr5WkL7r8cVL2/uxcZk+vXbkV8M0RSyRkSZd
         QpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=69RqotLGaHA+82ydaZexv7veZoHxIQWTY3fS43Pw+Fs=;
        fh=g3y0LYhlJTM/JgpyNPYqBqJnbn1zvDSXWgCwSfhIlxg=;
        b=GRxbeMZ1BoG2uJ4A18njTQocNF77yCvs2QxQ1NieM1+71i2is4N68gDIwfVwe5BO/7
         1mAdqowignJG88RpF6eb7UBymVKpgh6QTDLhE689ReT8hJtjODY+tzRYvDYg7d78hp5y
         o1th+5cBBywcGsdKp7B1xHmrretjcokfueAQQsfl9Z1ta7RHjyWAfHdAnAn+lNDDqzt5
         TOFD78iXEaIaNgXSGwEhIP8cfDaGWye+1O1Vw9S0wKXPrcf0uySckE8KgoFEFlvZ9Nud
         rkpoE6RK49dWU4mOrBteRt8Uvfl7h1xK9fX/JM8oxHfdr3evwY9qbmTaSo3Wtv09Wn1R
         gapw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777421701; x=1778026501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69RqotLGaHA+82ydaZexv7veZoHxIQWTY3fS43Pw+Fs=;
        b=XouY6cdBmyNIh0dlBiLkTAwnB5uxagHx5woiz+8aJlmB1rm7KhOOzoKCSnQrjxjums
         8HGgzOc/qe/D6JkkUc3HdPBxD0+DsWaTG3SFUgemCeJM632VVI86J3l7kjvMbhh7AsqT
         vcQMag2FXlveSI4ATrf9gMeH70WTCc7FIqcpNIZ7MQtCst9RE7AfsX9+NpwfLCf97OWv
         p/nkjZ+chLrSe2F/0y0H/Hdyl6bRVyQ39kt8S1wkjZw1NBXGYnmMi/4GNdLm59FdJ0qi
         V4jJ/xKzDFdywe16R3eKSYNm5Igdanh3VXjy3D9mu5zJDCY6epFWhrkf5/DNvaahBevt
         upvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777421701; x=1778026501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69RqotLGaHA+82ydaZexv7veZoHxIQWTY3fS43Pw+Fs=;
        b=ErvGPMyjsObWItQppYl8M8CMSej3sqGasPSlLjMrjaTFJCVjk0Pw96g97n23YGoxb7
         cHUxg111VBrtkzcfs7+o2OQoBa6pjNVkj5kR8tfaYG4mF2ZBCeAF7IHwwAwhuMaeJdev
         mXSh2XvyBPpfmHtsmHSTJATT9Hd+td9UoaImcLdxm26VyhNb4NsTxa3G7E/tWiJ1HlMj
         7IPqDEGPFdFMc/aSXV1dFUh/AA4zovPTEza5pXBO4vfmgw9BViBmaTz6hioZQkmB2b5T
         3iAVeAtauGRrTo0/JCDSLSvqGea0qW1vjNEN5+TsCT/VpQmN5xcEcoezfw3HmC8eCEeE
         bFew==
X-Forwarded-Encrypted: i=1; AFNElJ/DLp6Sc8/F4ZsgDT6Yq0IxPp732g9oPCV086BKfADaedFxZ4sju27tZSqZh4uuhOaKZ1fnX6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizBi2EE+e8Y/DKCoZyrmt3lrXloslFFoh7l217vsuU1QGfL9R
	BGyqbzHLnn+lSq9pvqHcM7RB9wvo6a9ZIv4DKaWG3wJvJwzxQQmamsd/47VZu/r4mV88qXWbOZi
	miA4JqInQdYqvpD1c2SVlrj2jPB6iGiW5wgooHxjd
X-Gm-Gg: AeBDiesUa0Mua92Tq3e/O9GYYJRgMfJ8XoLYhzWJU95mqCjsX09IathWk/x0GDkfmDv
	cK1IVLoGWjmzd47mx96bI0kYrh22FIVhvLWxRnYDqE8cOC2Q8IZaUD4248uR7g0MJN7dT+ScuAR
	S/75BHNU8zg3DVp/ezIewpf7jAUD8eb4EyW/HrwCZlSahZr3yLvLF3GSfX3KqSLMgKiPxiovvnK
	5OykS478p8pg/N/ZU5qwHypU30m92NBOFGKcVkV4rcwAH0lFlnNRmujm3H/HIeuDP89Cvxqcg1R
	HbWmkI+kv+Ob5IBPzSSdj5Gnwo1jLNcPvLOypqvoYn22QhjEWfF4gE+k8JfdSw2v1bSIVMUv+hu
	DaHQKcUMyIA==
X-Received: by 2002:a05:622a:a6cb:b0:50e:63b4:9b9f with SMTP id
 d75a77b69052e-51018ac63e2mr24179351cf.55.1777421700238; Tue, 28 Apr 2026
 17:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428205352.1247325-1-kuba@kernel.org> <20260428205352.1247325-4-kuba@kernel.org>
In-Reply-To: <20260428205352.1247325-4-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 17:14:48 -0700
X-Gm-Features: AVHnY4K28zIg_UV6cHdwcToXBqQwlhcqWbSAK4hYHGI2mLzgbnbXEvUfK7AC-jE
Message-ID: <CANn89iJFK1=RtREbXpiY8q7gudqVSJXFSqiwOyUOW9vTOaTNMA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] psp: validate IPv4 header fields in psp_dev_rcv()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, willemdebruijn.kernel@gmail.com, 
	daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7EC6348DB96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282151-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 1:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> psp_dev_rcv() is called from the NIC driver's RX completion path
> before the frame reaches ip_rcv_core(), so the IP header has not
> been validated in SW, yet. We expect that the device has done
> all this validation, but let's also add the SW checks, to avoid
> surprises.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

