Return-Path: <netdev+bounces-230132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC0FBE443E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED459562213
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7347234166C;
	Thu, 16 Oct 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep95c049"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0F3451B0
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628750; cv=none; b=F1T17WBn+B/Jo7/HDdR08rc3L0anBRGSnFjoHAOIXSvvRYy6T+70FUX8qWBHeUhWBaBRXvmvbDgxk0gRwzjdQVvnYrpcLHh/ZPjStIYQmXM6VQJKss3K0hN+zQMw32VXapsi88RoVxQz63e2jL0E8ZW6KKJbLzBjr1Bp8CKqPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628750; c=relaxed/simple;
	bh=Gf6CdowgcJaW13930Iudunk15ESM+xfAqwobszcKePw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZIG3kQdAlEjAfUb3s7FQnKUd8CLGObIyhwHIyhjAHqcRCzznCjM9GxhdNh5wuA3Orrb3MB3wI/dfLYRoN+Ug2FywSukzd4wX8sfu9JYa4poPLARQptM70eElMQQpVKjvmG0Heez7t/vi8YFd31Yp6cN0YNT4t3NMvdJ5E+A7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep95c049; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42f9f5a9992so7863545ab.2
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 08:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760628748; x=1761233548; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xg1jqEZ8SLRtVB/wwQT4BUuBiWGbY24yKgIhLLceEsE=;
        b=Ep95c049ZBg3vSweDVPbHVJWMfQMuG6IFOPhbcskA5d54Dm8fOWGinp+QToC6I0VYB
         wQ2qScy6qbrWq86FtqKTKqg6N6k4sAjDHpwEbrBOP89wxlc5w9sBDoCc/ByMAW1B776k
         o872BoJGqEFIviiT2meA9jbMp72tNZb10O2mS631HpUBAF3p4ECA2wXblE1KvYfRdwF2
         aQBuB/P1yQfO4VJzrbGpxQsgp0Rm+QoKHOkPw+uASE4SMXkI2CHp8zc694FECPF2zTli
         QQdI++x0k+yGnHCtw+DnyPWzG3jp14Ax9b1iOcJV9HWcSNqVuX2Eb1CoAp8S1NBV2/Eu
         bUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760628748; x=1761233548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg1jqEZ8SLRtVB/wwQT4BUuBiWGbY24yKgIhLLceEsE=;
        b=WeypsWdsMqvREKpCMCdhmi48gsJ5v8LIG638GBU4/LLEPRoPRluFo4kea25TfRyfH/
         GfIT5wIESKOOcXrhQcP8ScO9l4FYczSzmbyVBfwFpHuRrYD/xcSCwXYEbs0stkwLuHU5
         L+ONh5WtdU5qeHfkaZc7bMBuT+QISpLdqkri8JyaEk2m7+Q3tuC4Yw8ER6WONxvpg7mA
         I5bP4w6JcWkxEStwr4YtLR1egOR7Z8ql3w7aArPUPQl0aaGICDDkqBWTSoVv5bXnTSNl
         Rifu8HvP5fH/DOvIugngbNyhaxgJ7y5Zh0gYBIwzWyfqXRb5LGzUwQfphVIjvNj9rJg8
         +pmA==
X-Forwarded-Encrypted: i=1; AJvYcCVUnTWawoXe+ynWpP2Saq2XPdhhlwN4ttPeodpgUvNcp2mUI9e6RiufxJrahOGIJ2To1tYcoEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGIdOepmP7xdADCDpa5yaj0bzl5r0a2OCD9YsFT/phk9XS3PEl
	6lQvxvdnhoG81bq1ayNmWplLHgXSvVy6vvyxkqW5IS8xwztM8PAKmESqBCvrbQ==
X-Gm-Gg: ASbGncuIuadz8W6Pl2kdNIec42Qwx/idC+4Gf+mZOZdSG8CPTbUvh2s2fC9OMXDTr5j
	UrTL0gZMPZdZ/Sm42jkf0HF0lshxY5g8GH2IxPQjP59m5tI1Qu7eHbYKw2Lo0xHP9VkyoacetHV
	g7WeI9JPOlZ/9sW5741poDXFhvKUkQG21/YfXUy6tyO2BTXg3uWvRWy+PBXZk3RBL7ASkAs8Rhr
	KYS8kj70eENFxmYJdlitzQKC73XTsYH+vdRoMJXm/Suqr0O7JT36pQoLaA0XkagMiwavJ5BdoR5
	Rp+8S48Gio04gL8gRMDbdYUutZ2lUhZrdi8QZeVkLbCpVo1exUFYWzXBzK8YHNQuv/mXvNNv/j4
	KHaiVF4C5Qb1AU2X5cYd9fPFD0qFz8Qnq2i/C6emBG5KqveRYqtcQTjyNU5amgsqG8/rA2AT/AL
	jHihVVsgwRKeokjYiLXPnTWwLYNV6ogb6+cKxDosidc9axliAs9c+RiVObXbxpSlUOKP4=
X-Google-Smtp-Source: AGHT+IFaJcDyYzcIAs6W9GlcRP7pTItVAi//1Dq5hM0J3sZVcmeXnYAd1N7zNnUNY1XfH9PO1LzQEA==
X-Received: by 2002:a05:6e02:3e06:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-430c524fcd9mr8067245ab.4.1760628747528;
        Thu, 16 Oct 2025 08:32:27 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:780f:d7a9:7dd0:9e2a? ([2601:282:1e02:1040:780f:d7a9:7dd0:9e2a])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f6c499743sm6973030173.10.2025.10.16.08.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 08:32:27 -0700 (PDT)
Message-ID: <743c0e51-77ea-4ecb-af1b-9558a084fa63@gmail.com>
Date: Thu, 16 Oct 2025 09:32:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v7 1/1] iproute: Extend bonding's
 "arp_ip_target" parameter to add vlan tags.
Content-Language: en-US
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeep@us.ibm.com, i.maximets@ovn.org,
 amorenoz@redhat.com, haliu@redhat.com, stephen@networkplumber.org
References: <20251013235827.1291202-1-wilder@us.ibm.com>
 <20251013235827.1291202-2-wilder@us.ibm.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20251013235827.1291202-2-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 5:57 PM, David Wilder wrote:
> +static struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level, int *size)

iproute2 follows netdev wrt coding standards. Please run checkpatch and
fixup long lines -- max ~80 columns. Column width in the low 80s is fine
if it improves readability versus splitting the line.

Applying: iproute: Extend bonding's "arp_ip_target" parameter to add
vlan tags.
WARNING: line length of 88 exceeds 80 columns
#18: FILE: ip/iplink_bond.c:188:
+static struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int
level, int *size)

WARNING: line length of 88 exceeds 80 columns
#25: FILE: ip/iplink_bond.c:195:
+		fprintf(stderr, "Error: Too many vlan tags specified, maximum is %d.\n",

WARNING: line length of 96 exceeds 80 columns
#46: FILE: ip/iplink_bond.c:216:
+		if (n != 1 || tags[level].vlan_id < 1 || tags[level].vlan_id >=
VLAN_VID_MASK) {

...

