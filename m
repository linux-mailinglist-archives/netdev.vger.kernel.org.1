Return-Path: <netdev+bounces-253376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EwcFLQtd2kvdAEAu9opvQ
	(envelope-from <netdev+bounces-253376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:02:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D508085B71
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45C1430022F9
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D41D224B15;
	Mon, 26 Jan 2026 09:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014D219A8A
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418161; cv=none; b=sjtzSoMoxZVnf/UMpQW0La3wmC6l1HZjLfMqUo4qL7TZnLvWThPaHE6kKUbsZFJLp4unxHnwke5urPatDtWURrnanqNLulmDRqWrDQT9LpuXB79bKlvJM/CXwkw1VyXT3q1oIFgccymB3cvSsv1YnqjglJkKO67Z1f2dVlFUlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418161; c=relaxed/simple;
	bh=7q5IxcdZrOaXLWprKCBq3VzXK/GPmVp4HGjmJuHXKq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpiMzY/8w1l57KDhsznVdfXXvMEE5Z7yqeQbiN38I7Dee2lk38l19XrCPvgzuhmPiyXIeBgcNsQHKUAb4TsbO0miHvccp5Lk6c84aQCBQzT4s2gnjR5DEmGFVuZhDd0wOdiogZrGiG8svQPW86844noItYz75ClH2ioBZpb73Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.221] (p57bd931f.dip0.t-ipconnect.de [87.189.147.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BE374C1A25A03;
	Mon, 26 Jan 2026 09:53:03 +0100 (CET)
Message-ID: <450d5022-48c4-4b7b-9406-5df9833bd26d@molgen.mpg.de>
Date: Mon, 26 Jan 2026 09:53:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: fix unaligned u32
 access in
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jedrzej Jagielski <jedrzej.jagielski@intel.com>
References: <20260126084442.413230-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260126084442.413230-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-253376-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: D508085B71
X-Rspamd-Action: no action

Dear Aleksandr,


Thank you for your patch. The subject/title seems incomplete (stray 
trailing *in*).

Am 26.01.26 um 09:44 schrieb Aleksandr Loktionov:
> ixgbe_host_interface_command() treats its buffer as a u32 array. The
> local buffer we pass in was a union of byte-sized fields, which gives
> it 1-byte alignment on the stack. On strict-align architectures this
> can cause unaligned 32-bit accesses.
> 
> Add a u32 member to union ixgbe_hic_hdr2 so the object is 4-byte
> aligned, and pass the u32 member when calling ixgbe_host_interface_command().

The line could be wrapped to adhere to the 75 characters per line.

> No functional change on x86; prevents unaligned accesses on
> architectures that enforce natural alignment.
>   
> Fixes: 49425dfc7451 ("ixgbe: Add support for x550em_a 10G MAC type")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v1 -> v2 change title and concentrate on alignement issue
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h | 1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> index 61f2ef6..eb5bf3b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> @@ -2798,6 +2798,7 @@ struct ixgbe_hic_hdr2_rsp {
>   };
>   
>   union ixgbe_hic_hdr2 {
> +	u32 buf[1];
>   	struct ixgbe_hic_hdr2_req req;
>   	struct ixgbe_hic_hdr2_rsp rsp;
>   };
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index 76d2fa3..4a0ccbf 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -1228,7 +1228,7 @@ static int ixgbe_update_flash_X550(struct ixgbe_hw *hw)
>   	buffer.req.buf_lenl = FW_SHADOW_RAM_DUMP_LEN;
>   	buffer.req.checksum = FW_DEFAULT_CHECKSUM;
>   
> -	status = ixgbe_host_interface_command(hw, &buffer, sizeof(buffer),
> +	status = ixgbe_host_interface_command(hw, buffer.buf, sizeof(buffer),
>   					      IXGBE_HI_COMMAND_TIMEOUT, false);
>   	return status;
>   }

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

