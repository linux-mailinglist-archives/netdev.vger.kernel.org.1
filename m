Return-Path: <netdev+bounces-269321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMVyK4iUu2m/lgIAu9opvQ
	(envelope-from <netdev+bounces-269321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:15:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701222C6975
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5815F302A7D2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66531327D;
	Thu, 19 Mar 2026 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH6By27m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239B27B34F
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900931; cv=none; b=t0JC5ErYVJD5BBKK1ZuSxVzZ5/NHzc7G/fWs3pnDXu0J2ei+kcY0pCU3KkYE8O1rmHD0z+F2mPZeF7oU2zVjLwBmKy6lNAzc3zGyUseWZtmw8da9tSNJuzWyXAa+rT7237GyPmOfes9qzLYADvclE+0Ny6joZW0uNbYi+s4GyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900931; c=relaxed/simple;
	bh=lQMAQUEaNFaF/8TrEH2EKeVMcgsU/69cqw9jbCo9AaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JO2V6ZNZSdiN8oOYwvtTruryQeXQs+xlAwnSotMiyWehub8/Q/E8GMV8sOLGszSVWpl2TmiEmYOd3hTHbG1v5nYI+8KPeTWeVeWE5uTKMZT/6FJwKg0K3lO232IHhlQohH7zn7cD1v9mUyRWHRfeso1+gTnp/t2HUoJ9aIF5vpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH6By27m; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9795ca4e6dso43428966b.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 23:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900928; x=1774505728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txy2LHsWryztaiodXgYqNx6B8tU+mwJK+bZ3myIk59g=;
        b=bH6By27mivImb7iNZAyOVIE/8jWagdgyojtRbaPr0MfvF6ZtNcveRMppY4sTHLcRPj
         rfyam4uwrhkqeRqo3Vwvc/dlRfufnebOyc0VeF5CFoNp9NiNSauuZujd/CPzt3RJeDCn
         7Perfi8vKfrobKWJByqKvyyK9tT7nfuSakWyckHKB3hcIOvTRbrsjyd0BkM6/t57jUS6
         uL1uxB7GoY/93bV6ZQ3EY17PC9/VSgCcYh7X6WMWIYNIXgr0nWDS1g+mY4GfjqQcVyEr
         d7J5YsNajg+eZyDX5wbh6BTrJwh8oDEf0AtHv7s7EAumVW660ldEaHm3IPB/0qLDwSvZ
         1q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900928; x=1774505728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txy2LHsWryztaiodXgYqNx6B8tU+mwJK+bZ3myIk59g=;
        b=bLxoukDYUnrOCKSlKqDyIeaKClo1aLl+IW+0svbD7t1BRAcfCiIeTVlbWu+QhqyQwp
         RhuRMH1bIZW9xjw+FQT6qLcChg0xKdigIiyKj4rSbF7dvPR7KFaqxnPy6HxKP/cMdj68
         uuNRhYUCQGNcW9Z0TAX5CFC/BHqXBL1Xm7i6qhgFoGKntVLWj4g+1BHY4leF5ryEvxor
         msvvwkQgAy51j1YcigAAlH1f99QlX8oT8ajZAThvdV2F71/tEmQF31SWOioQU7maHUca
         kVRPZESFi8r70e4Ng/CMaakShLsfvsQMEhtIMTTcZokvgvJIbkdDet978Uk/pOi3f16r
         KnGw==
X-Forwarded-Encrypted: i=1; AJvYcCXTEENo8vCHN51KBNe0EU3EDEpo3tmRySuV781YU0nucY4nmsQyo/zsZGETjcdWFQQphbx+cpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHVhiO6uMdLUVYHcrEkkZ4HjZkxQenJuwcufdGPXzl0vcg7CP
	lqWeU1KA8kkXV/NPDqmWDTPfy5IT2Ro8IjYD6N2QfISeQwxj/ENg7Yey
X-Gm-Gg: ATEYQzzjld8VJUcDSOCA0jd2ymlC8OsZN4EQ+RyRmKNFRzShKzNYS9gr9Ud94gVCLWE
	M4eOAoFctq1eyQtzk+R0eURI3a9K9VauVYh+fVT902ze6rPnOLElCP8PpctSKTwMGTfh+p0HFt1
	cw61h/Q9FTuLamN8iqxHekeblhxqgV7TVndL6Lshdzxwl+au5Zu1I8HdhvBA9cZEDExslM/DyZ1
	FErIwYbJB57YQ64x2EAdAn5Zts7AThH/qlQIJrd4z1+oBaXwG3ZLc1Ffg+IHcyCzRm3V4HNNcfa
	IWsyxFxG4NfEMPpFP13RP2KrhDRULo7mUGkjpGzVySu7WzBsge/eC4NIeF611rFV/K8mTU1lZyf
	j3Qy/Bjd5tL84+NJUYIJ5JzE3S0cSIxF06r+KwXXFzQ/CnoO8qfFcX/+3JocZ5i3I+jik8eKUxd
	6xEfBRwMg=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id a640c23a62f3a-b97f4801ab5mr405707266b.15.1773900927770;
        Wed, 18 Mar 2026 23:15:27 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5500::49b:47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f142cf16sm405096466b.20.2026.03.18.23.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 23:15:27 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	antony.antony@secunet.com,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next,RFC 0/8] netfilter: flowtable bulking 
Date: Thu, 19 Mar 2026 14:15:17 +0800
Message-ID: <20260319061520.356946-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317112917.4170466-1-pablo@netfilter.org>
References: <20260317112917.4170466-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269321-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.973];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 701222C6975
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pablo,

On Tue, 17 Mar 2026 12:29:09 +0100, Pablo Neira Ayuso wrote:
> Hi,
>  
> Back in 2018 [1], a new fast forwarding combining the flowtable and
> GRO/GSO was proposed, however, "GRO is specialized to optimize the
> non-forwarding case", so it was considered "counter-intuitive to base a
> fast forwarding path on top of it".
>  
> Then, Steffen Klassert proposed the idea of adding a new engine for the
> flowtable that operates on the skb list that is provided after the NAPI
> cycle. The idea is to process this skb list to create bulks grouped by
> the ethertype, output device, next hop and tos/dscp. Then, add a
> specialized xmit path that can deal with these skb bulks. Note that GRO
> needs to be disabled so this new forwarding engine obtains the list of
> skbs that resulted from the NAPI cycle.

+Cc: Felix Fietkau

How does this compare to fraglist GRO with the original flowtable?

