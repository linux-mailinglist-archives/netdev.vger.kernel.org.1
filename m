Return-Path: <netdev+bounces-119288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B0955107
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD01F1C21961
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3621C3796;
	Fri, 16 Aug 2024 18:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD891BE23E
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834096; cv=none; b=PFIzKfyyyBnX8/VUPsmGRyTGJrGpOv19Gs+QDXuKwvRIuQ9mb6rJeJ2iIT4nmW4m9zlByJm4sA1bZ1O6VUOXbN7QsBoExB56DoLGJHu2kVMcu/qDZwjfMIbzbDeBLQMgy9+03/C491cab4Dy2RCf18xb5XVMAPe0OavW8MARuao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834096; c=relaxed/simple;
	bh=Z6sagDCWF6XLuhLiXUU3YCM9Uh3/VznNL4m1kkr2NxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S00Xa6yLi6ucHsHaJV9Ak68l3q4Yc/i1GX8K4gHwJAklFx/uP9TytzqtDRmvCCgqbVm13YAYF9ofmc4z+xaJ3NiMuwOq+ALU+YUXYDK4GtibrJLZ78pqPkAX/Qz7wJFbKAoGcfWWPYXWpfSBquz8nw64OndzhWKyPQKw94B24xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7c87e50e-771c-4cf4-bb28-38e13b0542fd@linux.dev>
Date: Fri, 16 Aug 2024 19:48:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v3 1/2] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Jiri Slaby <jirislaby@kernel.org>, Vadim Fedorenko <vadfed@meta.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
References: <20240815125905.1667148-1-vadfed@meta.com>
 <ea38ce1d-0b6c-4a49-82f1-4c3d823525b4@kernel.org>
Content-Language: en-US
In-Reply-To: <ea38ce1d-0b6c-4a49-82f1-4c3d823525b4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 16/08/2024 06:26, Jiri Slaby wrote:
> On 15. 08. 24, 14:59, Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design.
> 
> Care to link it here?

Sure, with the next version.

> 
>> Implement
>> additional attributes to expose the information. Fixes tag points to the
>> commit which introduced the change.
> ...
>> --- a/drivers/ptp/ptp_ocp.c
>> +++ b/drivers/ptp/ptp_ocp.c
>> @@ -316,6 +316,15 @@ struct ptp_ocp_serial_port {
>>   #define OCP_SERIAL_LEN            6
>>   #define OCP_SMA_NUM            4
>> +enum {
>> +    PORT_GNSS,
>> +    PORT_GNSS2,
>> +    PORT_MAC, /* miniature atomic clock */
>> +    PORT_NMEA,
>> +
>> +    PORT_NUM_MAX
>> +};
>> +
> 
> The conversion to the array needs to go to a separate patch, apparently.

I'm not sure here. I'm trying to fix the regression introduced back in
6.8. The conversion to the array itself doesn't solve the issue, it's
pure net-next material. But the simple fix was NACKed previously, that's
why I had to introduce such a big change. I would like to keep these
changes all together in one patch.

> 
>> +static ssize_t
>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, 
>> char *buf)
>> +{
>> +    struct dev_ext_attribute *ea = to_ext_attr(attr);
>> +    struct ptp_ocp *bp = dev_get_drvdata(dev);
>> +    struct ptp_ocp_serial_port *port;
>> +
>> +    return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> 
> uintptr_t is unusual as Greg points out. It is a correct type per C99 to 
> cast from/to pointers, but we usually do "unsigned long". (int wouldn't 
> work as it has a different size (on 64bit).)
> 
> But looking at the code, uintptr_t is used all over. So perhaps use that 
> to be consistent?

so, now I'm lost. I'm ok with both options, just let me know which one
will have no objections to be merged...

> 
>> @@ -3960,16 +4017,16 @@ ptp_ocp_summary_show(struct seq_file *s, void 
>> *data)
>>       bp = dev_get_drvdata(dev);
>>       seq_printf(s, "%7s: /dev/ptp%d\n", "PTP", ptp_clock_index(bp- 
>> >ptp));
>> -    if (bp->gnss_port.line != -1)
>> +    if (bp->port[PORT_GNSS].line != -1)
>>           seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS1",
>> -               bp->gnss_port.line);
>> -    if (bp->gnss2_port.line != -1)
>> +               bp->port[PORT_GNSS].line);
>> +    if (bp->port[PORT_GNSS2].line != -1)
>>           seq_printf(s, "%7s: /dev/ttyS%d\n", "GNSS2",
>> -               bp->gnss2_port.line);
>> -    if (bp->mac_port.line != -1)
>> -        seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp->mac_port.line);
>> -    if (bp->nmea_port.line != -1)
>> -        seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp->nmea_port.line);
>> +               bp->port[PORT_GNSS2].line);
>> +    if (bp->port[PORT_MAC].line != -1)
>> +        seq_printf(s, "%7s: /dev/ttyS%d\n", "MAC", bp- 
>> >port[PORT_MAC].line);
>> +    if (bp->port[PORT_NMEA].line != -1)
>> +        seq_printf(s, "%7s: /dev/ttyS%d\n", "NMEA", bp- 
>> >port[PORT_NMEA].line);
> 
> Perhaps you can introduce some to_name() function (mapping enum -> const 
> char *)? Can this code be then a three-line for loop?

yeah, I can do it, for sure.

> 
>> @@ -4419,20 +4460,21 @@ ptp_ocp_info(struct ptp_ocp *bp)
>>       ptp_ocp_phc_info(bp);
>> -    ptp_ocp_serial_info(dev, "GNSS", bp->gnss_port.line,
>> -                bp->gnss_port.baud);
>> -    ptp_ocp_serial_info(dev, "GNSS2", bp->gnss2_port.line,
>> -                bp->gnss2_port.baud);
>> -    ptp_ocp_serial_info(dev, "MAC", bp->mac_port.line, bp- 
>> >mac_port.baud);
>> -    if (bp->nmea_out && bp->nmea_port.line != -1) {
>> -        bp->nmea_port.baud = -1;
>> +    ptp_ocp_serial_info(dev, "GNSS", bp->port[PORT_GNSS].line,
>> +                bp->port[PORT_GNSS].baud);
>> +    ptp_ocp_serial_info(dev, "GNSS2", bp->port[PORT_GNSS2].line,
>> +                bp->port[PORT_GNSS2].baud);
>> +    ptp_ocp_serial_info(dev, "MAC", bp->port[PORT_MAC].line,
>> +                bp->port[PORT_MAC].baud);
>> +    if (bp->nmea_out && bp->port[PORT_NMEA].line != -1) {
>> +        bp->port[PORT_NMEA].baud = -1;
>>           reg = ioread32(&bp->nmea_out->uart_baud);
>>           if (reg < ARRAY_SIZE(nmea_baud))
>> -            bp->nmea_port.baud = nmea_baud[reg];
>> +            bp->port[PORT_NMEA].baud = nmea_baud[reg];
>> -        ptp_ocp_serial_info(dev, "NMEA", bp->nmea_port.line,
>> -                    bp->nmea_port.baud);
>> +        ptp_ocp_serial_info(dev, "NMEA", bp->port[PORT_NMEA].line,
>> +                    bp->port[PORT_NMEA].baud);
> 
> Maybe even here with if (iterator == PORT_NMEA)?
> 
Should be ok, will make it in the next revision.

Thanks,
Vadim

