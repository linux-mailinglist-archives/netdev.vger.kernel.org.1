Return-Path: <netdev+bounces-202499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2CEAEE186
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3221690D1
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D83028C852;
	Mon, 30 Jun 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GgYPgXu6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEF728C5DB
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295185; cv=none; b=f/nbWvek01d4q6eGJeOrYUw5aRPqKIqCbRM+/jtxt7VNh8vZqqXnM846uvlQYLSEIKOwqGOyPLlo7MWgG16YVu3NhkRlrSMtSEghz56Wb9GC7b0bR7G9hXA45vt2zBjk4+UPdGO6AHJkPT+1SHMhFHqBsDjMS5fsFKN6+P2aYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295185; c=relaxed/simple;
	bh=EKbypWq1FlONhmPWIS5B8mEdbfenWC/UIXb4JIHYn3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CvPbmdij4c6POGigQWJU9nW3R+ipCUBQGdIhxpEMgYVAbPMoIrGjPI/Wa/1cmJ4EKcKTyq4dCZhwrcR/EnoiEduho3yVl5OGGAJMh46cvoqp4k2LKcX58DB+5FNoGA/cP4Mh+94TeUVxgFOmIHf8GGQdmHzqwIh+Rd9atuC4MPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GgYPgXu6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4531898b208so1412255e9.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751295182; x=1751899982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DehbCpLPPr5Vcumpumwy3dIrriLwUg9jpAUh57SLAgA=;
        b=GgYPgXu6GKp3JrqrkWfWtJObK7Zb3UNdmw25rrdj4U0AfWJKiAqMaNjhMAHmmQKMFe
         Nhfz8cN55i6/6AV241/X8TOCCsL94ifivSueywgpurE2MDGCKijEPOw9LOys0RNFJfn/
         5RkIgwwNfNSQP0wvN4Brqb/h1gTYUuYJVWBcqvQ3oGKlRUtHE2lepBGN1Q+aX72MmJqh
         ayUb8KvtdrGcAEUQeIYnSotiUYDpm5+TpsxqBMV+hxnEJiS/EjJhossRVQSJIldTf339
         8EolnaQ/8ZHDbhy2cu+a6p6MTwlqxStG+kKUwMENlyPVrxONrrjJbVCG2pN9IH4rzpY5
         5bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295182; x=1751899982;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DehbCpLPPr5Vcumpumwy3dIrriLwUg9jpAUh57SLAgA=;
        b=kv9jGiefOb15iav8kU6J7BZoPo2i+S4Z2q53CjIPTKK8M3LWc/ZR2WiEBXs3ZUzVS7
         Bl6o/0/6k3hlTTE2ljwZO/nvO3HlodenP6MTtcHU4DI/jzoXMlzMSLpgVx3CwAwqJ2NE
         2gmrI41HhiKV8S5HTSTTkpBYGvYRvM2AWsiFpLfJoUYbziZfJnU5+x/6RVNdN4yTMh3l
         tE5fYGTOdX5GI+zbbBi+Kxkzwpn3yL7wH25TuFfxMyWCYSewIR/QWbW31Z/4A6MtErzi
         q7GSoU4pGLKn3dlF5Dlj22YEgyK6bPwfQeGIX+M/imgMoQ+KECwlgfL1wHdh/B6L6WwE
         4ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpfWIrUNwv3NsBE9Cr5pjupvArQlQ4voXtUif+iqxQUgLvng4O5pmUUf50hjhChN2q9fc1m+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoFTwZ3caOAgeL1r8O5RYg/UdFNGZLeTG1FDdu2lW0Do9sw1AG
	OnIwbFvdaBPh11rvavt1HXymvwsFDy+q3vU2dHGoYwwzEi7ZHYMDAPUsPF4ddHZ2xx8=
X-Gm-Gg: ASbGncuFBkuyLq9dNpW30he9g3Q+WvbY9U6cGGoQ1FXvR0CEpRJ0Avzl1nZqwfI1PF3
	88vey6+6o19InOWBVMmTkKHL9JC0xcCoMSr3Qrpq9+/5bl297yiKv8ciseP8z+KXNdWZlLjv9P0
	MtTK0ECnGSphQPaIguTN+GJe8qnOMV50hUxB5GTnnHZPbgV4pjSK6RVyUvwJr/WDmgeBhjWCxfk
	G8ZrVoYmErr+/5Y7CpOjPpbmiwS6GfGZC7GxRoTg9VhTalD1/IrtvEM2kFyHycBqvW0sZOy6Mma
	kzMyJSQgDjI66UpPCBIKcE2dIodeW5tzIouWYZXPUTkRef5l0BCrU/olHGXGZc/I/KxyoMTk6gJ
	jkewU5Gq3UnT9o98CNR7oGYSEiYcZa6FOi/9kJc+OfXDqNj0=
X-Google-Smtp-Source: AGHT+IHObVBNzcK8FpD8U2h2CjhRiaENGj7cVHQZqmRm89+X/AW/+VEluKUeztSst+wELveye9ytNA==
X-Received: by 2002:a05:600c:c0c3:20b0:453:bf1:8895 with SMTP id 5b1f17b1804b1-453955642e3mr18964535e9.5.1751295181618;
        Mon, 30 Jun 2025 07:53:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:cc64:16a4:75d:d7e2? ([2a01:e0a:b41:c160:cc64:16a4:75d:d7e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45396f24796sm76136635e9.1.2025.06.30.07.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 07:53:00 -0700 (PDT)
Message-ID: <99780599-91e8-4fc7-98be-1afa849e7db2@6wind.com>
Date: Mon, 30 Jun 2025 16:53:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] ipv6: add `do_forwarding` sysctl to enable per-interface
 forwarding
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250625142607.828873-1-g.goller@proxmox.com>
 <f674f8ac-8c4a-4c1c-9704-31a3116b56d6@6wind.com>
 <hx3lbafvwebj7u7eqh4zz72gu6r7y6dn2il7vepylecvvrkeeh@hybyi2oizwuj>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <hx3lbafvwebj7u7eqh4zz72gu6r7y6dn2il7vepylecvvrkeeh@hybyi2oizwuj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/06/2025 à 16:47, Gabriel Goller a écrit :
[snip]
> 
> Sent a new patch just now, thanks for reviewing!
> 
FWIW, I didn't see any new patch from you.


Regards,
Nicolas

