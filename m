Return-Path: <netdev+bounces-298161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id raDUGyrJKmr6wwMAu9opvQ
	(envelope-from <netdev+bounces-298161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:41:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D428A672C9D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 16:41:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Otj0wooT;
	dkim=pass header.d=redhat.com header.s=google header.b=muLvoXJ7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298161-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80312308AD79
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0963D5226;
	Thu, 11 Jun 2026 14:41:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2E3A75A6
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 14:41:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188879; cv=none; b=M2FJhqWZA7nabnrH0YLyisKM1zM9TCwF8RSgzXxbj/g4fV+rh1z9kOBRvpYNVyceDNsg7ojmoXuenc39MHCoTwl/Pw0hOlXOLbqSZ8SSn57Ruc+eH8VBs+H7Trkcpp02sNz2M2br4vzZO15jAlgVAmaZ2xu9yaduesVRiYQ/5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188879; c=relaxed/simple;
	bh=L+ZorF2xDuuSmKh6yuc+nw46rL9U0BR62/czr5/Eznw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8oIs4IRYUnInsoYv7FjomRIP2SfSm5j+kL/kuh2W4R8X48nKarZj9bnddLp++R1llDgkdNlqLTu+kiBh6wuBoGdfErbPpsCQiiwzz7OOnWRYxVtAj30uN4odr1SIIyENz6oGz5oU6rxozEL8dd81glcFeQFAj6n3lY05x3pqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Otj0wooT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=muLvoXJ7; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781188874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tyjEG+W9Hat2flkhk/jrtX0PYeov58aCgm5xfgox1ic=;
	b=Otj0wooTPV4Tm055pGHp2J3wdvge2vQbBFbEQcG1txASEoTKNjfunt7kmVF281u+BI/g0s
	Xqi9wbVDlx3kvqat5xmaEytfQBohtrjdZYajnN0IaXVQQS5UOS9q60rRkCrOB8UrZcVHiM
	46zuPb/Z4laPbFwb6ZBoSJ5NsEgTqTc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-kkRlIkzRPDadsGWQWhx7NQ-1; Thu, 11 Jun 2026 10:41:12 -0400
X-MC-Unique: kkRlIkzRPDadsGWQWhx7NQ-1
X-Mimecast-MFC-AGG-ID: kkRlIkzRPDadsGWQWhx7NQ_1781188871
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef55779d1so5138155f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781188871; x=1781793671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyjEG+W9Hat2flkhk/jrtX0PYeov58aCgm5xfgox1ic=;
        b=muLvoXJ7p5QvCglcteA21lhmiRAYEnnC+MTGOgzdb9royBmQX6Ci59XSsq4kPkCZZG
         Q9xBsncVhbxZDnw/qq8hyfQQzFLqgFADn1yaCcQOysSZ0LLAQCZSqSe037j6elP5YERe
         RBLRispJngaa56dQoLz/c3Egyv3MJXVtTCm2YP1yTifCHVIYKz36dDZTYMo4/C940/mA
         fg3odIFBdPl+8SelA/hbfWI/hlWLUZs2e9r8jIHTiGuCUJrgb909QBfXrD2uZ19XiYbc
         BZMDKxvFrpR4qT+bBqKLMMZJCN0meqZofR3Rxe2O6K8eQUGGA7LNTDDfjMxUH3H/Arfu
         7jiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781188871; x=1781793671;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyjEG+W9Hat2flkhk/jrtX0PYeov58aCgm5xfgox1ic=;
        b=QT5MqBctktH5WJxp7mY2bIn42bQGIQAWtiOna6zWMhllZPxxjz9rlwYSffhozp6zkX
         h+r9+5751PA/j0umv+Y+9DHctDpqJRh1+UYkwdqE9ymoTraP8WB7X9OVgZNOVof65sA5
         ccupAM6vtjYCWtqSp+C6WEnpITx6B+DBNyy7ckGNrTx47+zvG4WVs/pc+lm2OJL8bjVP
         DAFE4gFNSp3eF4J5dx0nwytlPo4JDBzBebFTmYzBjb0iAPXzp5wOxad5xuLUSVtHseYS
         tvczC47o+g7FKARA5dfL1yVoxUuikVzjZU5bHPHQL6HiJe5UIwYHhOx/1dOVPwxzqgWu
         tS1g==
X-Forwarded-Encrypted: i=1; AFNElJ8AnLXXTUPRWA6oFGJMi+Icu4VW/id/lJv1OOJf7DwWJqAhsI7rarK6FJTA/x+aCjAbTZLNPbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXN/gA2bAyro5C0FEdUhTRg2FSYNYQMkHVkcJu5YWSUlm+nnvw
	IjwPjRldlzKYkd7cRyfZi2kol2bPj9WLWh+DYS8ie2AOFr2ysi0VrgKKuYLf8L9K29CZLjnlhoO
	ePduN1jk7NhjemXwI7Z1zDVlKWPnvjV1ntYUhQttFI0DxMs/2QwMG2ecSbg==
X-Gm-Gg: Acq92OEF0MDkU2MYO6SKQLNXUEdxpybQ1ukjO6Y59CLzpQ+KwYSLS+nb5MVRPI4rWcT
	pJK2E6htMpaIxdjL3GZ5rsNY9in7gJaKc9eUQEr2337Cpz/zynTrvGXmSYJpPS3WnCDyNHgGb66
	M3Zd3mMP+8SXuQ6IktDeAbG7cTm6QsBUVLG0IFj1jAoazGcb2ovtcWoA0lff8PARUuCkbOL10kv
	1LsyILuRqNGiKZ+4tCsZabYtHdnk/Svrcd55WdWEYl/K0aFv4m9FCtkbno3ZezZUdFZDcrZghv4
	bBiex3fauSKV9MVYV/sqXIYbAvzDp9cIsu/ExP/Zs+wlclItFK0Knf8nd0TpIEymnOhxvJbSVqd
	ao1x3ViD2IjJ0ewXHI5ALzt1vXJoHpR09VdjlUmXh6uuJghuNPQ/xr643R9Pck1/b0w==
X-Received: by 2002:adf:e844:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-460675ab3f4mr3862525f8f.22.1781188871006;
        Thu, 11 Jun 2026 07:41:11 -0700 (PDT)
X-Received: by 2002:adf:e844:0:b0:43d:1c21:ead5 with SMTP id ffacd0b85a97d-460675ab3f4mr3862474f8f.22.1781188870377;
        Thu, 11 Jun 2026 07:41:10 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm90601715f8f.5.2026.06.11.07.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 07:41:09 -0700 (PDT)
Message-ID: <20be8f49-4d85-430b-a651-c4aecd172a57@redhat.com>
Date: Thu, 11 Jun 2026 16:41:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
 dpll_pin_on_pin_unregister()
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Oros, Petr" <poros@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "Vecera, Ivan" <ivecera@redhat.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>
References: <20260607183045.1213735-1-grzegorz.nitka@intel.com>
 <20260607183045.1213735-4-grzegorz.nitka@intel.com>
 <5ad977af-9bbb-4376-b0a6-2b1867223145@redhat.com>
 <IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <IA1PR11MB6219E71E2581AE3A4C91F870921B2@IA1PR11MB6219.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298161-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:grzegorz.nitka@intel.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:poros@redhat.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:przemyslaw.kitszel@intel.com,m:anthony.l.nguyen@intel.com,m:Prathosh.Satish@microchip.com,m:ivecera@redhat.com,m:jiri@resnulli.us,m:arkadiusz.kubalewski@intel.com,m:vadim.fedorenko@linux.dev,m:donald.hunter@gmail.com,m:horms@kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D428A672C9D

On 6/11/26 12:01 PM, Nitka, Grzegorz wrote:
>> -----Original Message-----
>> From: Paolo Abeni <pabeni@redhat.com>
>> Sent: Thursday, June 11, 2026 10:50 AM
>> To: Nitka, Grzegorz <grzegorz.nitka@intel.com>; netdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; Oros, Petr
>> <poros@redhat.com>; richardcochran@gmail.com;
>> andrew+netdev@lunn.ch; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Prathosh.Satish@microchip.com; Vecera,
>> Ivan <ivecera@redhat.com>; jiri@resnulli.us; Kubalewski, Arkadiusz
>> <arkadiusz.kubalewski@intel.com>; vadim.fedorenko@linux.dev;
>> donald.hunter@gmail.com; horms@kernel.org; kuba@kernel.org;
>> davem@davemloft.net; edumazet@google.com
>> Subject: Re: [PATCH v14 net-next 03/13] dpll: fix stale iteration in
>> dpll_pin_on_pin_unregister()
>>
>> On 6/7/26 8:30 PM, Grzegorz Nitka wrote:
>>> Neither parent->dpll_refs nor pin->dpll_refs on its own is a correct
>>> iteration target at unregister time:
>>>
>>>   - pin->dpll_refs includes DPLLs the child was registered against
>>>     via a different parent or directly; blind unregister WARNs on
>>>     the cookie miss in dpll_xa_ref_pin_del().
>>>   - parent->dpll_refs reflects the parent's current attachments, not
>>>     those at child-register time. Another driver may have (un)reg'd
>>>     the parent against additional DPLLs in the meantime, so we miss
>>>     registrations that exist and visit DPLLs that have none.
>>>
>>> Walk pin->dpll_refs and use dpll_pin_registration_find() to filter
>>> to entries whose cookie is this parent. Symmetric with
>>> dpll_pin_on_pin_register(), correct under any subsequent change to
>>> parent->dpll_refs.
>>>
>>> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
>>
>> The current guidance is to avoid the Fixes tag for net-next patches,
>> when such tag refers to code already into Linus's tree.
>>
>> If it's a real user-visible issue, the patch should target net.
>> Otherwise if the intended target is really net-next, no fixes tag please.
>>
>> Unrelated important node: sashiko (gemini) still has some comments, some
>> of them looks new and relevant to me i.e. the possible divide by zero
>> bug in patch 11, see:
>>
>> https://sashiko.dev/#/patchset/20260607183045.1213735-1-
>> grzegorz.nitka%40intel.com
>>
>> /P
> 
> Hi Paolo
> 
> Thanks for your feedback.
> Regarding patches with 'Fixes' tag ...
> Actually patches from 3 to 7 in this series are indeed fix patches for the existing code.
> It was reported by Sashiko earlier for this series as pre-existing issues.
> Kuba suggested, at least this is how I understood it, to include it in the series to see
> a clean AI scan. 
> So please advise on the next steps ...
> Should I simply remove 'Fixes' tag from the commits and keep those patches in the series?
> Or ...  to remove them from the series and re-send as regular fix patches on 'net'?

The current guidance for the Fixes tag is to avoid it in net-next
patches, unless fixed patch is only present on net-next. My reading of
Jakub suggestion would be to drop the fixes tag as 'are not actually bugs.':

https://lore.kernel.org/netdev/20260604155422.167314ff@kernel.org/

Note that I could misread his wording.

Fixes tag could be stripped when applying the patches as needed, and I
think that could be preferable to a repost just for such thing, given
the current PW load...

> Regarding the latest Sahiko comments .. this specific one about divide-by-zero panic
> is false-positive. It was fixed with the latest revision.
> I'll respond in a separate message with my view on the other high ones.
... unless sashiko points to something really relevant. Please report on
the ML.

Thanks,

Paolo


