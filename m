Return-Path: <netdev+bounces-220568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92835B469AA
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 08:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D88E1CC63A1
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61DF2D0274;
	Sat,  6 Sep 2025 06:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNH2RsmK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334202C324C
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757141871; cv=none; b=s+KCgg8/AoF1qL3h3MWNxOoc7MAo1Eq6Z1KKV5P85IGAtjK0ClcvvaVOvvaVdsY62GiiFyTdqotZvopXlBMI+zvNn9Y084SSfjVXk+hHa2IvFTbU2eMdfgP6GxEsd7aEaYxzk3XhN455TYNh6CR/8jpuqKW608AA4l2xPuz1bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757141871; c=relaxed/simple;
	bh=ZdjKkfJoHiNakSwH8vDlKRd1pmuPHtWQLHwJ3ze4QIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0pjey9dpwNo4wDfn38wXeV5/C5eKz0rC/xPXFz8pIPy2LbqOSmdneBTE0TniOpmcreciJ9atZnw93KP/xCuuF3DJnOigdpGHSe7slNX8jJG/4Jc8XHIrq0x4/lXMoonBgouD7zYxoupUPv4AaFBL7owflsPVYixFF8fhYhP7Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNH2RsmK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757141869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMjDlR0sGCSb1S5XkqRhY0gCtJvKgV/eSaD7F6oVPO0=;
	b=TNH2RsmKgnzQCBCzyRMlSz2yuk10Gp38IAmW4PpmhMn5L+4bTOcXPqNkrDrVPDxZWO4Nwl
	Izq9xCsb71CKzpiAg9e9vAD6k4k5yWT9P25Pks+h/Ro7cs8rgK5rYfJTE16fr7Y7W62TUg
	YDIz4620DUM1XciffpRuA0zhguURnKM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-DJjOIiObODGWwQ0SudJ6NQ-1; Sat,
 06 Sep 2025 02:57:46 -0400
X-MC-Unique: DJjOIiObODGWwQ0SudJ6NQ-1
X-Mimecast-MFC-AGG-ID: DJjOIiObODGWwQ0SudJ6NQ_1757141864
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B57119560B2;
	Sat,  6 Sep 2025 06:57:43 +0000 (UTC)
Received: from [10.45.224.31] (unknown [10.45.224.31])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 630641955F24;
	Sat,  6 Sep 2025 06:57:39 +0000 (UTC)
Message-ID: <2948c2d9-1600-444d-89c9-c129ddfba109@redhat.com>
Date: Sat, 6 Sep 2025 08:57:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/5] dpll: zl3073x: Add low-level flash
 functions
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250903100900.8470-1-ivecera@redhat.com>
 <20250903100900.8470-3-ivecera@redhat.com>
 <20250905191905.05476586@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20250905191905.05476586@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 06. 09. 25 4:19 dop., Jakub Kicinski wrote:
> On Wed,  3 Sep 2025 12:08:57 +0200 Ivan Vecera wrote:
>> +/**
>> + * zl3073x_flash_download_block - Download image block to device memory
>> + * @zldev: zl3073x device structure
>> + * @image: image to be downloaded
>> + * @start: start position (in 32-bit words)
>> + * @size: size to download (in 32-bit words)
>> + * @extack: netlink extack pointer to report errors
>> + *
>> + * Returns 0 in case of success or negative value otherwise.
>> + */
>> +static int
>> +zl3073x_flash_download(struct zl3073x_dev *zldev, const char *component,
>> +		       u32 addr, const void *data, size_t size,
>> +		       struct netlink_ext_ack *extack)
> 
> function name doesn't match kdoc, and "Returns" -> "Return:"
> 
> No idea why the kernel-doc script doesn't catch this..

Will fix...

>> +		rc = zl3073x_write_hwreg(zldev, addr, *(const u32 *)ptr);
> 
> you're sure data is 4B aligned? Otherwise get_unaligned()

Yes, this should be always aligned but you are right, using
get_unaligned() here is the safest.

>> +		if (time_after(jiffies, timeout)) {
> 
> time_after_jiffies() ?

I miss that macros, thanks for pointing out.

Anyway:
time_after(jiffies,...) -> time_is_before_jiffies(...)

Will use.

>> +			if (signal_pending(current)) {
>> +				ZL_FLASH_ERR_MSG(extack,
>> +						 "Flashing interrupted");
>> +				return -EINTR;
>> +			}
> 
> Is the flash dual-banked? Normally random signals interrupting flashing
> is recipe for bricked parts.

The download is safe operation... During this the driver downloads
block from host memory to device memory (RAM) and it is safe to break
this operation. (What should not be interrupted is flash itself (device
memory to internal flash memory).

> A little odd to use "timeout" for periodic check. check_time?

Will rename.

>> +	/* Return if no error occurred */
>> +	if (!count)
>> +		return 0;
> 
> Did I already accus^W ask you if AI helped you write this ? :D
> This level of commenting makes me think of code generators :)

:-D no, I didn't really use AI for code generation :-D

As the zl3073x is the first standalone DPLL driver I tried from the
start to write well commented code :-) But maybe I overdid it a bit :-)

> +	/* Enable host control */
> +	rc = zl3073x_flash_host_ctrl_enable(zldev);
> +	if (rc) {
> +		ZL_FLASH_ERR_MSG(extack, "cannot enable host control");
> +		goto error;
> +	}
> +
> +	zl3073x_devlink_flash_notify(zldev, "Flash mode enabled", "utility",
> +				     0, 0);
> +
> +	return 0;
> +
> +error:
> +	rc = zl3073x_flash_mode_leave(zldev, extack);
> +	if (rc)
> +		ZL_FLASH_ERR_MSG(extack,
> +				 "failed to switch back to normal mode");
> +
> +	return rc;
> 
> Should we be overriding rc here if there was an error on entering
> but we cleanly left? If so that _is_ worth commenting on..

Oops, this is an error, we should not override final rc here... Instead
of this the driver should make its best to revert back to normal mode.

Will fix this.

Thanks for the review,
Ivan


