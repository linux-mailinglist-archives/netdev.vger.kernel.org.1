Return-Path: <netdev+bounces-146165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BC9D2286
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6527C1F21401
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D787613FD83;
	Tue, 19 Nov 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vI11EZuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76297139566
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732008672; cv=none; b=LD9M5GKC9W4zfu8rLS23haJdMigTQNkM0mlzyeD/nUWznS7v6HsX4Zrmt1aGrAIhG0FVdOvXlC1mHvhNPA6+UM0Up8hSFbZndZOgVoZ8fO2MG7yejMFLnqpqwRp5PYFwAo4rMdfoXYxRz3Rt7QAOTK3+EZpxYZSxUxs6D4KECtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732008672; c=relaxed/simple;
	bh=6Dmdl9IItyp8HHKlAi+EzKPP4xsuHCy1g+kX8mSRt8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZO+6uDA1CfGLmmZbZqdQxTqz8fRIETOaUJlFuhjWen+FWDk9nuEnRRhxQvjb27prT9yK6LQQct5dnr2GUaQsvDXAHcZaiWHWIoYtjlKj2Iw3CeTf6SLdOJ5CIXJ+NztPycnN8ftrb1bXBrlLBTjBD94OraCwt4iUk5BWqzbbt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vI11EZuP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38248b810ffso499027f8f.0
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 01:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1732008668; x=1732613468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69Eh6f2nHrxn6OhhoJX7OXsqWEyE+bPtjMxfpqvMJo8=;
        b=vI11EZuPxbsVUumTGScFaSa07Cxy0ypHrpOZgBhxS8T06JXBbyevQ58kVHYuTqJn5d
         Fc4hA/c91RBnMqhzqELP3PTs3uNaosheUFAMfsTPRunotljJUrjY2Yx6AYgTYRl1grHF
         ALakdGvCUsrHOz+xKgrW5UreLV6rHbDZlzKl7uD2EMQPa3iz2aXUDfVu3iCl4xqYSmvA
         8N5iiN2i8l99p3fDtqATIbtRESS4AwHCZXSF8nlWf9n2TFJAynpqOaM1PLGUplLTHLfH
         735oZrrYCauqwqopV8xDfAwZ578fhyvtg+ti5fKkVwpQTYdU3YdbuAwbQXUoG0F8xNPi
         5P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732008668; x=1732613468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69Eh6f2nHrxn6OhhoJX7OXsqWEyE+bPtjMxfpqvMJo8=;
        b=qDilggbNK/FNgvpKgYNuiAFC2H9tm9KVo8ox8SOukTimda26WUvmVgPLCgwAkjvh5a
         Bk/98PL8NMLsPaXqyAkFNLwdpDCIqEriGSfPbEzz63AykaAce0N9K9Fma9L8GKjdIKaW
         vHcIP6iRRVvpA1iuChh0fyAfNMdikIoSRLYwmE4k1y8PHFXvmshkpqe7qHC8/DQFRZt3
         IwWl+9jB0CJIZqKrMewjAvN7/3gJ/uoSLithBvz165SdL62Pjo42Adp2rGFBG0Ap3JGl
         /5sqYrUIQMf7O2N7MqLKdN1mAH63gSh1DFHDkKPx8nnEK7D7jYL3RmasK2xXJz13+Nf+
         Vsag==
X-Forwarded-Encrypted: i=1; AJvYcCVCqAu1MDfWX+TZQ9v45PvuLiuxG18CgqZmstqATtN/ltd/MLAWPw2VWvOweecqaCUdwVP9DLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMhgEYXCMqwjdo9hoYArhMKKHpyPcLzLiELpPjHZqUKLLe+42
	7VC71jacOZ+w8VmmKcUbVUNYwv4KSff58ljQFDryk4KPzE/xsNVJI4RwY6Hqxfw=
X-Google-Smtp-Source: AGHT+IF5cuRARF1J6DhAqhBp0a273rSZfoETzT03SqV0DnHwI2SodUwM73fOtUocXPKY2BTjsWBjJA==
X-Received: by 2002:a05:6000:18a5:b0:382:3f31:f39b with SMTP id ffacd0b85a97d-3823f31f5d6mr6011736f8f.25.1732008667642;
        Tue, 19 Nov 2024 01:31:07 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3823bca7305sm8994657f8f.44.2024.11.19.01.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:31:07 -0800 (PST)
Date: Tue, 19 Nov 2024 10:31:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, donald.hunter@gmail.com
Subject: Re: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <Zzxa13xPBZGxRC01@nanopsycho.orion>
References: <20241117205046.736499-1-tariqt@nvidia.com>
 <20241117205046.736499-4-tariqt@nvidia.com>
 <Zzr84MDdA5S3TadZ@nanopsycho.orion>
 <b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4aa8e75-600e-4dc5-8fe1-a6be7bb42017@nvidia.com>

Mon, Nov 18, 2024 at 08:36:38PM CET, cjubran@nvidia.com wrote:
>
>
>On 18/11/2024 10:37, Jiri Pirko wrote:
>> Sun, Nov 17, 2024 at 09:50:40PM CET, tariqt@nvidia.com wrote:
>> > From: Carolina Jubran <cjubran@nvidia.com>

[...]

>> > diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> > index 09fbb4c03fc8..fece78ed60fe 100644
>> > --- a/Documentation/netlink/specs/devlink.yaml
>> > +++ b/Documentation/netlink/specs/devlink.yaml
>> > @@ -820,6 +820,19 @@ attribute-sets:
>> >        -
>> >          name: region-direct
>> >          type: flag
>> > +      -
>> > +        name: rate-tc-bw
>> > +        type: u32
>> > +        doc: |
>> > +             Specifies the bandwidth allocation for the Traffic Class as a
>> > +             percentage.
>> > +        checks:
>> > +          min: 0
>> > +          max: 100
>> > +      -
>> > +        name: rate-tc-bw-values
>> > +        type: nest
>> > +        nested-attributes: dl-rate-tc-bw-values
>> 
>> Hmm, it's not a simple nest. It's an array. You probably need something
>> like type: indexed-array here. Please make sure you make this working
>> with ynl. Could you also please add examples of get and set commands
>> using ynl to the patch description?
>> 
>> 
>
>It seems that type: indexed-array with sub-type: u32 would be the correct
>approach. However, I noticed that this support appears to be missing in the
>ynl-gen-c.py script in this series:
>https://lore.kernel.org/all/20240404063114.1221532-3-liuhangbin@gmail.com/.
>If this is indeed the case, how should I specify the min and max values for
>the u32 entries in the indexed-array?

Not sure. Perhaps Jakub/Donald would know. Ccing.

