Return-Path: <netdev+bounces-277310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE18CBnF2Gk4hwgAu9opvQ
	(envelope-from <netdev+bounces-277310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:38:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A753D506B
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67688307ABA2
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E6F36EA8C;
	Fri, 10 Apr 2026 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjPKKK5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="di6hxw8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6B3B8BA1
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813674; cv=none; b=Aksyxhved9ErVtWVuk3pa+WimIidyY7F4nrJASR4tjcum9d2awywrLPHS27TpLHr5/l0g6Xd4JbhRKB7jjHWXaxz+ql78fQATHrVFlIfmoB+33HTYZLxMNUyEDmnaSv473Qqhs3Uio/n65Gc9cVF3+uE3yhtd0L4XC5mA8c86u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813674; c=relaxed/simple;
	bh=tzEUoH0FkVHlL1WtFfjdSc5lPF5SeHrWnmDDZ0MF4V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdPa/+c0dLjlEHnvG7tjPjd5y7o37CEz9Y561ZO/xJ9xUlLhCzwnpF0Yusyl9M+RpOzAncpCc/BBf+ETnST/phQjt7yuD8/5Di/mB9tWDQl0XkbhHq79MQ4RVXpMX5vyZzAQ0YbvweUpinoTb811l0JogSX8UCcY8WsAx/EzV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjPKKK5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=di6hxw8J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775813672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOOTcFGxnrzrTtnktwvjMFoVHaeGEwhYa6Pm50725v8=;
	b=gjPKKK5X8BATwEStCCEFhdJa7yhM53U89EANxWmTpcaH/BTBFvVR5OJ3DOMYcufLS8bFvS
	hJ/Hl5CYGDN0jEN8UQljtaXMZ8Jtjn1v1xoKjTDPptPT3h659kVwEDchlKwpZLWLLypcmp
	P+dsA9b23xky1XKIw/9jD2pN9C9xZmc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-ClnwTugEM1-fe97EvZP-Dw-1; Fri, 10 Apr 2026 05:34:31 -0400
X-MC-Unique: ClnwTugEM1-fe97EvZP-Dw-1
X-Mimecast-MFC-AGG-ID: ClnwTugEM1-fe97EvZP-Dw_1775813670
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d03065782so1066982f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775813670; x=1776418470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOOTcFGxnrzrTtnktwvjMFoVHaeGEwhYa6Pm50725v8=;
        b=di6hxw8JCjL86FnefMybI4Qfme165IL+XX81m/caraMlhiN4IW0mwY8ZUiXdmFC4JM
         VRf7+421MH8sjpvsVXzG6qX/ly1gJGQ50iPHAgVX6UN0rsTyIMeHOgAWG1gluSlo9gQg
         v53iFNoBlppgoPxbCWKQcI6pEriTRISTDPr9yRj+oXRCQfVH6LCx5dnVmV5ko4jxPnwZ
         6OVZ9jTFlBtgvfjCmHZQAp6RxgtVWfLrJTq2ZqNn96hJoZ+16OO9AgXDlJwBtuemFFsv
         QUkSC499vfP0CjvhFF/xRc3Y/QennA17bw82rwsRlUU56w6Cvdl/fQ7LTMrwnZetWTBn
         QMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775813670; x=1776418470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOOTcFGxnrzrTtnktwvjMFoVHaeGEwhYa6Pm50725v8=;
        b=lUevwBSH9eHNVV2DvKhs416LuCUFukkYRM23J/+L+SgZDkyE0k/QWe6UtTd2jPVvY+
         bNiAieMv44QR6mCJFgU+Q+zs6glWlJTayLZXPl/lK7uYrcdSd+8+A7hDERJiHgvpmxzM
         LrMLWROeewvMq9LoZ15knXG1zSvI/6smMaYK3BMiXhJg/LF/Oc90l2yU6uT1lDAlbGXh
         vhz9pfUGJu8eMyBVP5zZqDKboUO6Imly4YwtntMzyOsI1+/sNyf3sW5pruFxT38aN7xm
         IdyPI5VJhvgnUAOtu+D0cVjUjofvyxsPjOtERjA0+dHcJuSnvp4W83/GS5p8YZneNhbD
         9o/g==
X-Forwarded-Encrypted: i=1; AJvYcCVFBTqY4ql0KlQFsNY5m3TsrjfFIwiNOtPhKrrs5dA5ruUDTj8l/xHewP0UQWiyndVmMGtNk2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/JlHMHMLTQ/aFiJjJGByLQAOtyFeAZ9yPAmUVs/t7TNhKEHX
	CARLyLHeRn2C/dRUh/kIHqLsCQ3yeITwC6stI5H8S3L6xmLCn3vuIQ7Gf6SeYkNguB4xrkNAuZT
	Jhx+EJrScVfu4sOm1zDj5AoZxj+VyyoFZp6VUpgtlikwd9nqPlR9ciwg/Rw==
X-Gm-Gg: AeBDieu6ls8bRMyXBRyVUR6n/9BekputFk1E1SXtLB0Xq0sj/ukDu2U3mzn240OJfTu
	g/9EWirsrRuNtBUdRMudBCfykyGhLwiisMG3zGZYmBsjoeTAT4jgJbhwvLBlKbbi8RryWal9viz
	BN9GU8BarW1OiwC8GpGjRZZWZJqYaNg9wtpPnYgWRIDuWWyj10GmObgNcx35k6viVMVDARzh5PL
	TF6QxEFRimwxr4EywAhWQLtZ8OuPiIRuDwMw0H/H5vvbKgIBu3rpP6I3kEyPdpEy90t9KAjIeAq
	HQ7KGeq1RWFpFG3bfpaIto/VsAc/DCYj3uN+70y+N3bGwt7AJPHnmvL93W8t84reXc7bYsHy6dl
	quUA0MFQ32P5i9gTVPyPi
X-Received: by 2002:a5d:584b:0:b0:439:bdba:56be with SMTP id ffacd0b85a97d-43d64255118mr3234528f8f.10.1775813669867;
        Fri, 10 Apr 2026 02:34:29 -0700 (PDT)
X-Received: by 2002:a5d:584b:0:b0:439:bdba:56be with SMTP id ffacd0b85a97d-43d64255118mr3234492f8f.10.1775813669361;
        Fri, 10 Apr 2026 02:34:29 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a74sm6481641f8f.3.2026.04.10.02.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 02:34:28 -0700 (PDT)
Message-ID: <24a12da3-00f5-46ff-8719-b7a8654dd460@redhat.com>
Date: Fri, 10 Apr 2026 11:34:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 4/4] ice: fix
 ice_ptp_read_tx_hwtstamp_status_eth56g
To: Jacob Keller <jacob.e.keller@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Timothy Miskell <timothy.miskell@intel.com>
References: <20260408-jk-even-more-e825c-fixes-v1-0-b959da91a81f@intel.com>
 <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260408-jk-even-more-e825c-fixes-v1-4-b959da91a81f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-277310-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 85A753D506B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/8/26 20:46, Jacob Keller wrote:
> The ice_ptp_read_tx_hwtstamp_status_eth56g function calls
> ice_read_phy_eth56g with a PHY index. However the function actually expects
> a port index. This causes the function to read the wrong PHY_PTP_INT_STATUS
> registers, and effectively makes the status wrong for the second set of
> ports from 4 to 7.
>
> The ice_read_phy_eth56g function uses the provided port index to determine
> which PHY device to read. We could refactor the entire chain to take a PHY
> index, but this would impact many code sites. Instead, multiply the PHY
> index by the number of ports, so that we read from the first port of each
> PHY.
>
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> index 64ad5ed5c688..672218e5d1f9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
> @@ -2219,13 +2219,19 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
>   	*ts_status = 0;
>   
>   	for (phy = 0; phy < params->num_phys; phy++) {
> +		u8 port;
>   		int err;
>   
> -		err = ice_read_phy_eth56g(hw, phy, PHY_PTP_INT_STATUS, &status);
> +		/* ice_read_phy_eth56g expects a port index, so use the first
> +		 * port of the PHY
> +		 */
> +		port = phy * hw->ptp.ports_per_phy;
> +
> +		err = ice_read_phy_eth56g(hw, port, PHY_PTP_INT_STATUS, &status);
>   		if (err)
>   			return err;
>   
> -		*ts_status |= (status & mask) << (phy * hw->ptp.ports_per_phy);
> +		*ts_status |= (status & mask) << port;
>   	}
>   
>   	ice_debug(hw, ICE_DBG_PTP, "PHY interrupt err: %x\n", *ts_status);
Reviewed-by: Petr Oros <poros@redhat.com>


