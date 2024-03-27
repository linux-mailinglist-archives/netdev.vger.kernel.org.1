Return-Path: <netdev+bounces-82500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09088E6D2
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB762E2149
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 14:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9590614AD25;
	Wed, 27 Mar 2024 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ3RnOI8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CD13C3C2
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546252; cv=none; b=MgEc2UqaWAEuuiWj/Z9OsPYE0Fb7R3pQXOhXzqPIetuniXkxlXRyqkB5OWmT9SYIkhDTBjowC3T0tgK+WHz5atYgrhwNkfpN33SY8H/p5k2MVJGR9mw903bkaWDewlzkD1MdOoblFxtcRa/zg8pzuU2BgqCLngZ3UDdrMpD/wE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546252; c=relaxed/simple;
	bh=0XY9//HMaNHTRAMknvvS4g417tWnY3ABPrd/afaOHBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwFMPE0buJDHoWhFA+IfHO+v3OnCdVd/F4H2OAEb3VA4ScBlYQbdulGWJi3r+o5edBN6TdugYw9LP1+WI6/xBR1/sLfdSYOfiH8SUja2voVjHAcVkWsmxqJM374o2/beMEUH0mrj2RVwziohbB+3JUytCH+OYoRe/ZGfGi5f2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJ3RnOI8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLg38MFVhLXh0D5Ryy6sGfzcGNzaaaxhoktXDmAvMEQ=;
	b=WJ3RnOI86/sAHWAMgdQqLrMelD/t6XEAckeoelj8QBm91qy5NU+vsN7633SgriEFzcAgpu
	49OLRrd0n6XN7OqyRfFxgkebOUIRlojOjbNIfOpmnbNqVnIFEuO6YhEdmTBiQ+m7rZJ7Pb
	sDPoociN0YtKSPkXDCc/x+PAqojvRJ4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-OiO-lJsmNHKJt_G7KN1tSw-1; Wed, 27 Mar 2024 09:30:46 -0400
X-MC-Unique: OiO-lJsmNHKJt_G7KN1tSw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5684345c0ebso995938a12.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 06:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546245; x=1712151045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLg38MFVhLXh0D5Ryy6sGfzcGNzaaaxhoktXDmAvMEQ=;
        b=nMSaiWLiVJsx/lB0W3i33SjwoO0CcWyWd0QTp8/EtfMlDJDYG4iGefADEgI5gQLRUu
         sWlcuvX5PUieu3v+GWkqRKkTi55JqaQuOecIltX4NJkp03XnlK6gEF9ZqGOOXO9X72eB
         72pleP+rgU1VKGnvKvUdPOlrVDZ5wwNSTWc4KyFr5pHy/w4gWB5QUD+Ki9Sdp2N6hFhF
         efXEUAOQ0JSmrsfBoV9BwZJcrZT223owO2K/3JWO4sAn1jmyOiyJYtXd4UCWhqiI4Hfq
         cA5py118+PLavZ+DnpT9vqi7q4fU967KlQJ5yrGFwRQygCqlsg7fdlwGwbNjhc2KLdeu
         0DAw==
X-Forwarded-Encrypted: i=1; AJvYcCWgFlfVQtoluXNiLB7n1Gqs0FvJ/zQNGf+5vEdXElnfH3BUoQskrNydeFY5V2eBw7+fPLyPgAZ5u+HiFu0q53Pxa+la2ZI6
X-Gm-Message-State: AOJu0YzxCbK2uoEFslE7vh1jRm7VwW/diW5KisF+9PebtXr0huhMEhwQ
	Sz/Dy4nUQlWt5HPp6SPi6p3Shiu+R8WtOGDV7nJa+C+pyba6oEwGft6zu/+sMeFJ6bnCVpKe+8g
	eY4zWIpl+vwI+GR5ZXnl3nJ7vkea5avYl/2C3WnDniMv1TeQejAq/RA==
X-Received: by 2002:a17:906:4552:b0:a4e:ca2:f597 with SMTP id s18-20020a170906455200b00a4e0ca2f597mr464571ejq.30.1711546245273;
        Wed, 27 Mar 2024 06:30:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxMNQa6I7wHwsl8AheMWybiN2BzRa3S3xpZTZlv2r8DjsDL3nA8c8TtS4ntqPeWCUGEfcy9w==
X-Received: by 2002:a17:906:4552:b0:a4e:ca2:f597 with SMTP id s18-20020a170906455200b00a4e0ca2f597mr464548ejq.30.1711546244934;
        Wed, 27 Mar 2024 06:30:44 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709060e4200b00a4674ad8ab9sm5383406eji.211.2024.03.27.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 06:30:44 -0700 (PDT)
Message-ID: <7a7d7216-ae22-4908-af63-6b1dd96359dd@redhat.com>
Date: Wed, 27 Mar 2024 14:30:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] ACPI: store owner from modules with
 acpi_bus_register_driver()
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
 Daniel Oliveira Nascimento <don@syst.com.br>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Matan Ziv-Av <matan@svgalib.org>,
 Mattia Dongili <malattia@linux.it>, Azael Avalos <coproscefalo@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Jeff Sipek <jsipek@vmware.com>,
 Ajay Kaher <akaher@vmware.com>, Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 platform-driver-x86@vger.kernel.org
References: <20240327-b4-module-owner-acpi-v1-0-725241a2d224@linaro.org>
 <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hEiKJJWn-TVoyL6DEbCcMpL39_q+HLG_YZyjf9g29CXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 2:16 PM, Rafael J. Wysocki wrote:
> On Wed, Mar 27, 2024 at 8:44 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Merging
>> =======
>> All further patches depend on the first amba patch, therefore please ack
>> and this should go via one tree: ACPI?
>>
>> Description
>> ===========
>> Modules registering driver with acpi_bus_register_driver() often forget to
>> set .owner field.
>>
>> Solve the problem by moving this task away from the drivers to the core
>> amba bus code, just like we did for platform_driver in commit
>> 9447057eaff8 ("platform_device: use a macro instead of
>> platform_driver_register").
>>
>> Best regards,
>> Krzysztof
>>
>> ---
>> Krzysztof Kozlowski (19):
>>       ACPI: store owner from modules with acpi_bus_register_driver()
>>       Input: atlas: - drop owner assignment
>>       net: fjes: drop owner assignment
>>       platform: chrome: drop owner assignment
>>       platform: asus-laptop: drop owner assignment
>>       platform: classmate-laptop: drop owner assignment
>>       platform/x86/dell: drop owner assignment
>>       platform/x86/eeepc: drop owner assignment
>>       platform/x86/intel/rst: drop owner assignment
>>       platform/x86/intel/smartconnect: drop owner assignment
>>       platform/x86/lg-laptop: drop owner assignment
>>       platform/x86/sony-laptop: drop owner assignment
>>       platform/x86/toshiba_acpi: drop owner assignment
>>       platform/x86/toshiba_bluetooth: drop owner assignment
>>       platform/x86/toshiba_haps: drop owner assignment
>>       platform/x86/wireless-hotkey: drop owner assignment
>>       ptp: vmw: drop owner assignment
>>       virt: vmgenid: drop owner assignment
>>       ACPI: drop redundant owner from acpi_driver
> 
> I definitely like this, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> for the series and I can pick it up if people agree.


> 
> Thanks!
> 


