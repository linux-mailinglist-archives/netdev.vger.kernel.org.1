Return-Path: <netdev+bounces-116903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F6D94C04B
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F928481C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40A18A6DB;
	Thu,  8 Aug 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfbTfmjy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3943B674
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128879; cv=none; b=P+Ft1+iPKSy0crw9K/d1jlxeDNh7p4ZV9bsXPbWx2HnldioRPKlA435Y/l3SBN2OUsKVoa5XB3WDN0DO+s8D295M9tv9UiCWdbIwtYupvB6lMF3v71JgvsBSjTfx0UT6atbJHyjuRwCpoN62Whk3nKV70NtZOl5bp2C6/6za0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128879; c=relaxed/simple;
	bh=0qVpnrrQ5V7Oba/idyBy4VNiEB/PEX7w0W9rmTe9SCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHLmf/egKDCRmd1VVfP0ek298m0b1VonCoNTMjf2CEXA+8ILna4EPDgdvi3nIrqIPPvSGa+Bx1CfJ8at586ZCPhWJjUW69rSOoq3KIrJLb7lKa7wO5u/el8thg4C1Qh1juJLZcxdhoGAvvN2xKk2YTXJltUKJNDubLP+rFBTJ38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfbTfmjy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723128877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E6VQurNupLMkE5+xs4FU6tjwM3iI7P4QQzeCwz5WnMw=;
	b=LfbTfmjywVgGJUNO0D4NR6R7LVP16++7j/pyvwIX/PYh6YTpN3sGsgbzwBP2yqqh38mE6q
	jsnjJ1lI2jm58talEXVXsFP2QZJTIoZDy63ojzrNpsrXgrVBMNJ9wyrMYXwLQvlrRaRrTj
	a9FcWjEWC20okhkJVevbq8t9P1ouJxg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-J9hXCqd8Mf-C-AzaqRQL-g-1; Thu,
 08 Aug 2024 10:54:33 -0400
X-MC-Unique: J9hXCqd8Mf-C-AzaqRQL-g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E06D1955F43;
	Thu,  8 Aug 2024 14:54:32 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.194])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6CED19560A3;
	Thu,  8 Aug 2024 14:54:30 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 310F0A80E94; Thu,  8 Aug 2024 16:54:28 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:54:28 +0200
From: Corinna Vinschen <vinschen@redhat.com>
To: christopher.s.hall@intel.com
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1 3/5] igc: Move ktime
 snapshot into PTM retry loop
Message-ID: <ZrTcJGAMBBT2kClQ@calimero.vinschen.de>
Mail-Followup-To: christopher.s.hall@intel.com,
	intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
	vinicius.gomes@intel.com, netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
 <20240807003032.10300-4-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240807003032.10300-4-christopher.s.hall@intel.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Aug  6 17:30, christopher.s.hall@intel.com wrote:
> From: Christopher S M Hall <christopher.s.hall@intel.com>
> 
> Move ktime_get_snapshot() into the loop. If a retry does occur, a more
> recent snapshot will result in a more accurate cross-timestamp.
> 
> Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 00cc80d8d164..fb885fcaa97c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
>  	int err, count = 100;
>  	ktime_t t1, t2_curr;
>  
> -	/* Get a snapshot of system clocks to use as historic value. */
> -	ktime_get_snapshot(&adapter->snapshot);
> -
> +	/* Doing this in a loop because in the event of a
> +	 * badly timed (ha!) system clock adjustment, we may
> +	 * get PTM errors from the PCI root, but these errors
> +	 * are transitory. Repeating the process returns valid
> +	 * data eventually.
> +	 */
>  	do {
> -		/* Doing this in a loop because in the event of a
> -		 * badly timed (ha!) system clock adjustment, we may
> -		 * get PTM errors from the PCI root, but these errors
> -		 * are transitory. Repeating the process returns valid
> -		 * data eventually.
> -		 */
> +		/* Get a snapshot of system clocks to use as historic value. */
> +		ktime_get_snapshot(&adapter->snapshot);
> +
>  		igc_ptm_trigger(hw);
>  
>  		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
> -- 
> 2.34.1

Reviewed-by: Corinna Vinschen <vinschen@redhat.com>


