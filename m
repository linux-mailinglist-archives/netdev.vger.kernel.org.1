Return-Path: <netdev+bounces-289439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG1MK/1SDGqmfAUAu9opvQ
	(envelope-from <netdev+bounces-289439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:09:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A3057E5C2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85845302A4C4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374654C0437;
	Tue, 19 May 2026 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MWlKAqsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142F4C041B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192124; cv=none; b=LChmEKJSCB5/ydMGgSFN65MfAZoiqQ3UqlVASs6ucJ7p25FpPr7qNDpzTWL5cdcLBKp4dKlaVzDahn49WMIU5szapW1a6jK6MaA6qMKaEwkOmtzL3uPpPgDLYEPdi1iNJJBorTlMdw30bn2bTzowCIqDonMotEVfCoxmiwHjhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192124; c=relaxed/simple;
	bh=e6h0tO72to3PU8thjV+AhqKHoURvgfu/GeEfGz1AGIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIgi6LuUpE9wRrwgBcwVLzHsEzpphUxSrMMyi0JJ414CSVqMZ+izV7R3MNwxWCG/lq3zDYB0h1WvjBP5woQ0J9mssFUbEL2N8sOSG87HOeO+6f4neGoofZrMvX+9Z6JEjgGp2P1QcLcRDGz1szum380hQVS2blWFjYrkHvhsOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MWlKAqsv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479d593a0c3so2926353b6e.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779192121; x=1779796921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pc9ls6ISdMIH1NykmT18sDrVEK+ZnWHWMr5PgdhH2Ww=;
        b=MWlKAqsvoo2U7BoEbxYJgmltlSJ8IpsRuLSa8QuIuHq5KmTqyw6sYoOagrs9ENKkv+
         P0bfugUqdqohxu917n4jgEC0UEaehnFnNvoI3Ij8f14YdKQpjYbAz+ccPkzVQdhz8XqA
         iBZH5AKundUk4d8qdHITAFrrJroXrbVdM1ERFEtD6pWW+IY6TWnVQM9LbSC2YdSfkAdR
         uILPFAy/8+3YwI0dZirAFjv+KOmbSTo2c18xwHBcnm3c289ecIWTEouQOZ9vPBqlUnW5
         ayvPTFWCobCAvg9haP1VJHJKTYJAdT6uVIoxHGwCU7jCUHy3E6DIFcbpP3VONadqqYRr
         PVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779192121; x=1779796921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc9ls6ISdMIH1NykmT18sDrVEK+ZnWHWMr5PgdhH2Ww=;
        b=X9Mm7GqzlEbKoQ0LE4dPauhSzxHekWZ2S1nOaHcvKkQC3f1sDhT4us1mPY5bXUlTCe
         ax5h7Vw021d3fhichgHbMbMkiF4IeSs97QJk2Nib+Sm91P5fABQFcPJ3Z/KD4mq/3Ah5
         zDf4T8p658w02fap0USL7Oq2vhT7LYJCTyigt6Mrx6fgQT3JrjDSU7LOwObObG4yRHPr
         w08piF3oIWQWEaYfzeVr6Wk88CzqWxvcBCbmoOUgqwN4c/SwDT7vKoM7UsDmZRNaAHDZ
         qXTAOfe/P7cZEZ24creN7PfZdMsqZsRobKtKbDTif2XEGh/qHrfy7mpmVJPbS9cp0ESl
         EVtQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OWD6CekTNXEFZJMGLf9TtdCyeKMwzm664/fKwEvSIJAjMNCQYrzWPfcOsmY1i+rj25OGMirY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7clhN7hc7RZIsO8XayXTypKJoVPUwMuR/h5H+VAneBJbts40
	+INNaz8ctqdEcQJu2tMJp4ShqJCrNw1kPDTtz47ie5cx40DLltJxNFXmKhh7Qt0WfC+BMkf1qFJ
	+0qehDwkDpZIxHDm5cngko/icNsw26nCXaBjzGhXrnTBj3CMZ5rWjnOr9oqsiQYi8530=
X-Gm-Gg: Acq92OHB/AMR1jIsnExzBr7BtJX7D217ESPZ5uva7TE7vCPOjQKSZnjdy30vTSZYJeu
	F4P4KoPhKKCN6JVW5WLvGwLdRcDDW7OOSu7A1qeaIeItYIqw1UQuH+yFhu/UE3VVPS/rflFuAnK
	EMxCtUtnUgY4WwDb2ymywKFiPBFjPwGG4pENYzo/RwinO4KY73WRrgYbuTnK/R5vIZ1sdDSwtG0
	uj4RJp1G9p35PXmOsHKHuryyqL88uMnbWsf2yxLJiCgLvPXQ6QUfDYsUoHeVK4N4uKVTNGZ9AD+
	qRx8H3B2WkD3tl44WYFDdMrKi+1E0xRMAOKFYBAtE9tsa7wljss0lCUdhNhbm0Np2bnOvM82ZQt
	KhWuVeGg0Mql90B4YTJBVwWXgTbM4Hn9H0EPwGMNljtkyBDRgClB/WZLuuvD+mZTiQX2IbdCMli
	EoWe+ji79WC6sJdP297SQubJUNKWMIWGSmpk3SeahOmOT+oil8wgRSKbmVbLoS1T1EakZ/Jxb0
X-Received: by 2002:a05:6808:170a:b0:479:d372:b7d0 with SMTP id 5614622812f47-482cb7219a5mr11640483b6e.5.1779192120990;
        Tue, 19 May 2026 05:02:00 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:fcdd:239e:4fa1:a75d? ([2001:67c:2fbc:1:fcdd:239e:4fa1:a75d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164581fdf9sm160869751cf.24.2026.05.19.05.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 05:01:59 -0700 (PDT)
Message-ID: <9550ce52-c230-4a88-a2a5-a61727fc933b@openvpn.net>
Date: Tue, 19 May 2026 14:01:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/5] pull request: fixes for ovpn 2026-05-14
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ralf Lici <ralf@mandelbit.com>
References: <20260514231544.795993-1-antonio@openvpn.net>
 <98bf6672-334a-40df-a21d-c53fac584314@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <98bf6672-334a-40df-a21d-c53fac584314@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-289439-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: 30A3057E5C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

On 19/05/2026 13:50, Paolo Abeni wrote:
> LGTM, but sashiko idendified a number of pre-existing issue that could
> deserve some follow-up:
> 
> https://sashiko.dev/#/patchset/20260514231544.795993-1-antonio%40openvpn.net

Yes, we're working on them.

We've also configured sashiko to pick up patches directly from our 
mailing list, so we can work all the issues out before sending further PRs.

Thanks a lot.
Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


