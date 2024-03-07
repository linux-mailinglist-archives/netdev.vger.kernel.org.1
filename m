Return-Path: <netdev+bounces-78304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B79874A6D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043721C226E4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0E839E7;
	Thu,  7 Mar 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhp8Jz7L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3D82D66
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802741; cv=none; b=ojhT9LNTAOaN6ROBkLWBRD7SLo6cclaaY5GNjxRPShvfSJHvErWXV5wbGx9kqVNYXGr/EuUGXz5AfJS23UNJn6hHWfylV2/FmRFO1x7gzom+iUalv5eM4osD+DPJtoeuFaScBeON4UTIwsKIjkP0ff4UOURHqBprCHBi9syze9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802741; c=relaxed/simple;
	bh=FdiV7fjV6ZMjTiBpAFllNtXjS8Z2MyeA5Q3IRV8Eey0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gm8OeyYMSBdNGVw3xiU/xo7noUmsMC/ASUbLCtIwPNymtMbLrncT0KALD6dJ8WvTnyvcI3MYbc1NHv8F+MQXSgPVJlzKnserN8bq5zy6uyxh14owdVhQrXV7XJNstAUQCO3A/Qe8vTVTx4IH4D8NpurR+im27cKh3aYlh9O4xUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhp8Jz7L; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512ed314881so643624e87.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709802738; x=1710407538; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BlzAS1QIl3bUAl44ril6592URuR6LZQsuSR547DwpDA=;
        b=lhp8Jz7LAvaQBFXB8VWPGDdVQb6SLTQG7AQdbdCUhzO3A7l9ds8rm2HCItf0705m/l
         GSHMbhCqDJSACGjkYSv35OmebfnV3cIzjLfRKm3a1MdqBoBxlO+gaCeI2cg4sKwEl7qw
         SoP6zCKnPE16VK5KsUH/7OS2QSO19Ysab53aEM38wBc0TKaZedwtj0fP8FDmEluUbRAx
         JO9EgQE5lHmy+7wp0z/EClDWH5oMH0XvGFSQixAQBEo0qutk765KDr4u6eUk7qQnoUpa
         pKocn9+Zr1ep+5hWESWSEfnpUx4NvDYYCOuUe5M8cYl4nw8tbyhKaxUJiy0AvZQ+DChJ
         1vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802738; x=1710407538;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlzAS1QIl3bUAl44ril6592URuR6LZQsuSR547DwpDA=;
        b=CWQSUAVbdfziQzHJkIcpYbdb2iEBHfU4t92eQ64TMiRnNCnSvwqL0GeX9gHCnJHFJZ
         4ABjdFpx710FuR0aFtHQvY5qFERXXAguOaLOiW6K5cvAfWOfwUMT/NR0AmdR2MFtofWQ
         GGbXtCYAdzgqJURg3Tm5UK5BCyrg9GEP3umKpSy3A8fpY53+cl3j0g2jH1dal8+H2Gii
         Ph57oVxk6gRWd33+c5bgD18fsdTVzAM5gqR98Bxjj1ooI1zlThKJNrSZTYIoOTXv6FAW
         A0uknyAfcTFFvzxgsq5wnOynRULz2IzrBYYbM63qu1pJGjpD3+xKkbyNaNmFB9ct0ZoK
         1xSg==
X-Gm-Message-State: AOJu0YzmrOhGeiJhdq9Ax1AuijUdS1pdcBr5bH8a6/l6ZRIEgXEpIg0d
	VW0IFWtjxmbGXIrbNIs+HoJ7GBdL2FbcJMHWx54BS4rJtzWEK6EX
X-Google-Smtp-Source: AGHT+IGOts3OBa7ujLi+Aalr9OEmXndj6cVbtNkVAMx4iiIupjk79IzhBoUx2cGQ2M5hmu4CRp+1EQ==
X-Received: by 2002:ac2:5f69:0:b0:513:3e94:7ca3 with SMTP id c9-20020ac25f69000000b005133e947ca3mr923333lfc.48.1709802737778;
        Thu, 07 Mar 2024 01:12:17 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm1974562wmq.21.2024.03.07.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:12:17 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jacob
 Keller <jacob.e.keller@intel.com>,  Jiri Pirko <jiri@resnulli.us>,
  Stanislav Fomichev <sdf@google.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 5/5] doc/netlink/specs: Add spec for nlctrl
 netlink family
In-Reply-To: <20240306160458.3605e8aa@kernel.org> (Jakub Kicinski's message of
	"Wed, 6 Mar 2024 16:04:58 -0800")
Date: Thu, 07 Mar 2024 08:58:00 +0000
Message-ID: <m2frx2h10n.fsf@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-6-donald.hunter@gmail.com>
	<20240306103114.41a1cfb4@kernel.org>
	<CAD4GDZwtD7v_zQzeGDu93sropHbRsRANUMJ-MAB1w+CZCMyXuQ@mail.gmail.com>
	<20240306160458.3605e8aa@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 6 Mar 2024 22:54:08 +0000 Donald Hunter wrote:
>> > I've used
>> >         enum-name:
>> > i.e. empty value in other places.
>> > Is using empty string more idiomatic?  
>> 
>> I got this when I tried to use an empty value, so I used '' everywhere instead.
>> 
>> jsonschema.exceptions.ValidationError: None is not of type 'string'
>> 
>> Failed validating 'type' in
>> schema['properties']['attribute-sets']['items']['properties']['enum-name']:
>>     {'description': 'Name for the enum type of the attribute.',
>>      'type': 'string'}
>> 
>> On instance['attribute-sets'][1]['enum-name']:
>>     None
>> 
>> It turns out that the fix for that is a schema change:
>> 
>> --- a/Documentation/netlink/genetlink-legacy.yaml
>> +++ b/Documentation/netlink/genetlink-legacy.yaml
>> @@ -169,7 +169,7 @@ properties:
>>            type: string
>>          enum-name:
>>            description: Name for the enum type of the attribute.
>> -          type: string
>> +          type: [ string, "null" ]
>>          doc:
>>            description: Documentation of the space.
>>            type: string
>> 
>> I'll respin with a cleaned up nlctrl spec and fixes for the schemas.
>
> Hm, is this some new version of jsonschema perhaps?
> We use empty values all over the place:
>
> $ git grep 'enum-name:$' -- Documentation/netlink/specs/
> Documentation/netlink/specs/ethtool.yaml:    enum-name:
> Documentation/netlink/specs/fou.yaml:    enum-name:
> Documentation/netlink/specs/ovs_datapath.yaml:    enum-name:
> Documentation/netlink/specs/ovs_flow.yaml:    enum-name:
> Documentation/netlink/specs/ovs_flow.yaml:    enum-name:

Ah, sorry I should have said that enum-name in definitions already had
'type: [ string, "null" ]'. It was missing from enum-name in attribute
sets and operations. It turns out that all the existing usage was for
definitions.

