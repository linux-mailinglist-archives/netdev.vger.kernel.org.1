Return-Path: <netdev+bounces-52822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE258004D6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840BD1C20A59
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1DC15480;
	Fri,  1 Dec 2023 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="l8BAbKX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4C10F3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:40:35 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so29107066b.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701416434; x=1702021234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sz8TgoSO7HYblHK0tgTJzGRRiFKRRHYYQJ0Xbhf9+xA=;
        b=l8BAbKX2gpapBJAMv2UxT+Zy+hxspg5UKgU87IxEC9UxjlXRhlwyKMyyoof0MzL4Ii
         Myg86t2I0qY6bpxfrAdXaKq2iHRmEDGkPCe5cYb/UeSb7vnTy+J7vohYI/SA2plnDXBu
         focd+/sB4cApYV2vmEGd8+CGpMq9ZyT4oq3xHW+eVdux9gVWdgsnX/i4UC+dLhVZmY7d
         tELLvTWtQuwt+Ci6UviysflVXPMGijJu/OixX39tQu1DjGIpoAoAHKip85ST6zcXKOvi
         wHNUJr+JRnHgdd1R9XWxViOSsWF6fi5BrAk+sz2NOD1s0vv/W86EVjHbtemYhZORnj7B
         ILfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701416434; x=1702021234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sz8TgoSO7HYblHK0tgTJzGRRiFKRRHYYQJ0Xbhf9+xA=;
        b=s31VDrNdyaUJ0hEQF6J8B543IojHVUd+b9BCau2CR9pfZ5j1YS+ff06CcD9AF3J/36
         1Cde6iZDytDo3CsTRcTfTUYBZyJMqlTgq3PyIniuo4ic3fah5Rbbhbz+Go0ZKVyKaD/5
         ZZwsaOcq711AwWrwI5cTuNmRQtaPbPj8g6fLKobTXLqIcXVsOmxduQyVkuo1OOq6pJ9s
         2vyk4rjwyWUBNfXX4S2kw9qFNqPdZpYpaqGjfB3GDP/JB6/0jifCzeLE9EKfHbz9ENIc
         L5h05Uur1AvXaJnj/4HU5vN+F5In2hPnOIIBVbzgnZQF12RgutsAs54/eKAEWHjBaFm5
         /zew==
X-Gm-Message-State: AOJu0YzFWMCJ4fkGykhmkeVGF/xtVHhfcq4qxyMq1UtkU9+1uNFu//kV
	usPYEz61miQJOlK6aQ27ls6C7g==
X-Google-Smtp-Source: AGHT+IGgqqWjAQV5JcO5OGsBpcsZcs8sPdEvKDT8ioKQRJ0V+39oxP+0bhkq+pthqvVwvNuwkRQcaQ==
X-Received: by 2002:a17:906:5399:b0:a19:a1ba:8cef with SMTP id g25-20020a170906539900b00a19a1ba8cefmr487745ejo.141.1701416433751;
        Thu, 30 Nov 2023 23:40:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906a41500b0099cce6f7d50sm1577972ejz.64.2023.11.30.23.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:40:31 -0800 (PST)
Date: Fri, 1 Dec 2023 08:40:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Bahadur, Sachin" <sachin.bahadur@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next v2] ice: Print NIC FW version during init
Message-ID: <ZWmN7ifRPjuxK7f0@nanopsycho>
References: <20231129175604.1374020-1-sachin.bahadur@intel.com>
 <6404194f-3193-49e0-8e46-267affb56c24@lunn.ch>
 <BY5PR11MB4257E2D47667F2108BEDBE0F9682A@BY5PR11MB4257.namprd11.prod.outlook.com>
 <fadae2d9-68ab-4a1a-bfe1-78d0f1c2fb13@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fadae2d9-68ab-4a1a-bfe1-78d0f1c2fb13@lunn.ch>

Thu, Nov 30, 2023 at 07:13:11PM CET, andrew@lunn.ch wrote:
>> Yes, this info is available via the "devlink dev info" command. 
>> Adding this info in dmesg ensures the version information is
>> available when someone is looking at the dmesg log to debug an issue. 
> 
>Ideally you would train your users to use devlink info, since you get
>more useful information, and it should work for any vendors NIC, not
>just Intel which is spamming the log with firmware versions.

+1

>
>  Andrew
>
>

