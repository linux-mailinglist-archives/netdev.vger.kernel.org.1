Return-Path: <netdev+bounces-278585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKhkMFbI3mmDIQAAu9opvQ
	(envelope-from <netdev+bounces-278585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:05:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8C73FEF43
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 882BB302290D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9388D396B63;
	Tue, 14 Apr 2026 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG/2gu0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCA38AC8E
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776207951; cv=none; b=L4ugvYo8L5j+Iivg+R/B4nvaf6NCwhE1cbL41mw8o3mujbz8E27uyXmCYWeA7HTECnoWonr7Rb6FB8dr6S9fzpmSY4I2atVNYiHGXt68AxeGDs1VhjSQvA0pjFyNbXM0UCxjk68rvlM3vpn0F5eykz8wIUj154F7LQcneujdYYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776207951; c=relaxed/simple;
	bh=ulJiA40YjWBzinlQif5Nk1h/1JoKF6J9GjoMKAkxoTY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/Hh8Dz1LH1xp14WpwM+RrLoUnfHoJUu8AuRPDX2tM1aInhIhEdcJ2S+/YqR7dDVuMNrGNjY99OY96+2BlnQOm4KhmiD4Hl7O5QSGCLGmbbMITOliMHIaP79hboL33bxwA+D8LlZ9y9iLxDT5LxwcCfDIayLfEvyxW5p6jJ3UE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG/2gu0j; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732165d1eso16838298c88.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776207949; x=1776812749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIy4aYaXvRpOFfPSJZ2zgV8yIQ5jTx0wxsayXzjvZfI=;
        b=mG/2gu0joxHbqKfVK46rv12lCwT7xYJ7dkb/YxblPQlo1BtQDqp4uD2VkzYecvvN7Z
         QUrPIS2mW9Zg9+iIHnpLQJPUK5/sSRRV+d9Gn0YrFYct0oL8EJAWRJhhCJHl9R0vAAv2
         gplhG107XDIT+5UnNwg9Lx/1rZ0uriOx+kgexo/ZEC7TEVpWen+NCnJv45Lga37WCbQ2
         mWDo3n8+4SNrBU9nJoZOZd5gYd0TqhTXtTDWLx/NdmXYMoTgO18LsGYkZTu72H0CyKeN
         4z8Yk9Ko0sjVvA31g6vNPFsfqsUO50m+CjkkYkjipWvt8QuTCiC6+0xIg/0bilQUFA0Z
         lvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776207949; x=1776812749;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oIy4aYaXvRpOFfPSJZ2zgV8yIQ5jTx0wxsayXzjvZfI=;
        b=nh4JrpqOKeT68g5oKi+q+6pGRYW+AgxEO1PhxgDA06sO2R+y1SS4cUoyXDFPBiYt+y
         inBo+Y6OB0W6H3c46MKbZLNWa08rH3ZO5gXrGUbXluPT3sj6H+BHleu7NK5ul/h8nwOs
         G9chGa1vYLH2wb+DTzaJgZ0QwU+qQZnPWDgmXlC+qswLUsZBKaMgb2WC1MRomEVdUqhL
         km23M9hXfEQ1Hbt1vZNMYGc/+nCdjDJDF2Oh40nynrgHGhkZVB4M7buKH8sYyB8iWeF+
         OWz6nzzsOMvpe1h+4YSwe0qNwf/JU6O5K0N92rNhKeofgSybPNCG5HvEZ0HBf/bK9UK3
         Otyg==
X-Forwarded-Encrypted: i=1; AFNElJ+oJ6TI8D6F7IH5fUcy70n2WdTPNUQklgDGtqBHDIlzU//Ev79ZZMxVxl5ikmZ4KO1M+8keeOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YypHhFrLGe8X79d4fxxslGdtd7w+lGjS5PAhWwCeOGCrhw7Wb36
	5meL7o/1shetDI7Db9UA/70AyR+hLjUEUDwQfZwzkIvI/H58cGEqixYe
X-Gm-Gg: AeBDieugYTzlLJsZFQNcTbCciwzl4Ml5BA63pkxuUpBKMkLyqArEhTqcOy5ASdAg/ST
	tNz2vU66aJEx2XiNCUDG8ypcN0VEOnz+eFmPLO0sgwa11cIWGKq48ZZ3vAL7Jehi8dMJaPuE4DA
	OsvEth6PCCJakAh7kdpdPBGmO9Tx6tSaYSZf7JLhvnO0awN/9acXxs5sAxwbKtkX+fWbYxhT24G
	rznsUZbL+xYeQOr3URAQRLKX5L9kTTLMXh9i8WyyYJjxu6pSnif2Ijq0Rg1sXTw8rTMpMAI5d2l
	V+P36sLIwgm+31bCAw69SW9PeJ1O07Ul4ExtImE3ZvXObpwg0K4FfsARvZzcYon7+GgXEnrlRJS
	8h6AdQ+tgXiVOWptKIob+dJTymHPZVm1MpS3qwbsIHzuVG5vpdgBm9oyAz5oFkMpDqgqODkfZ+F
	EUxmiws9fiIVV6WGJA4zyNF3x4+720wCw0vgt3SyRljtfLeHg=
X-Received: by 2002:a05:7300:8c1b:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2d8b8142df1mr5698464eec.3.1776207949270;
        Tue, 14 Apr 2026 16:05:49 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c016198sm75119eec.1.2026.04.14.16.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 16:05:48 -0700 (PDT)
Message-ID: <c34567b0-a8b3-4c89-88e9-8ae507756944@gmail.com>
Date: Tue, 14 Apr 2026 16:05:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yuqi Xu <xuyuqiabc@gmail.com>, Haoze Xie <royenheart@gmail.com>
Subject: Re: [PATCH net v2 1/1] net: hsr: avoid learning unknown senders for
 local delivery
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Felix Maurer <fmaurer@redhat.com>, Ao Zhou <n05ec@lzu.edu.cn>
References: <cover.1775056603.git.royenheart@outlook.com>
 <b053e938014c9bac22f7f687ecc2970f23a2b74a.1775281843.git.royenheart@gmail.com>
 <adYwjxLBBaLY52Wb@thinkpad> <20260414145926.0Lwoa8ca@linutronix.de>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <20260414145926.0Lwoa8ca@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,ti.com,ee.vjti.ac.in,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-278585-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA8C73FEF43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/14/2026 7:59 AM, Sebastian Andrzej Siewior wrote:
> On 2026-04-08 12:40:15 [+0200], Felix Maurer wrote:
>> IMHO, the only real way to prevent excessive resource use on our side is
>> to put a limit on these resources. In this case, limit the size of the
>> node table (bonus: make that limit configurable as Paolo suggested).
> I am slowly catching up. There was no follow-up on this one, right?


Hi,

Thank you for checking in. Please excuse the delay as we are only able
to work on this part-time.

We are still refining the fix approach based on the recent feedback to
ensure the fix is suitable and robust.

Thanks for your patience.

Best,

Yuan

>> Thanks,
>>    Felix
> Sebastian

