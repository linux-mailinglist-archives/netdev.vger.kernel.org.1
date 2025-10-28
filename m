Return-Path: <netdev+bounces-233587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A0C15E9D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DF23A6E83
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910EE33C529;
	Tue, 28 Oct 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="PB/ldTLC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE822173D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669534; cv=none; b=iv3Gp4sKikSFiFGqfmEx3qM2WzwIQBCOKM/0jHg9D01TmxX2/8y1NF0CTrgwEB2qMOu+wBZ8pCIXEAg5C9F8u1bNUO5b9S3xQM2r9Ox6JXHg/Fe4mco/f7ZGXEbhfthtFwdbecl6IZqNxjFMD8wErLbD3GGBoj3POG8GZllIkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669534; c=relaxed/simple;
	bh=vyhmROQN7MnkqpkByX+OptwXuIIkUPsDYsUeiDzsYxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAM/KSstxkFm+67F/pogPF1W5d5apuHyxJESPEXyzYR0a9fpqtS/ga7BxFVr4frIYRKGhmrzQBApqGhiC3hup28HjjIuFxag9eyWHzBhO474YNKYsT+gCDZt7W+VTquLk083A7f8L6AFHWB68syK/ezDifDSZPGFpEZrw/whUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=PB/ldTLC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290ac2ef203so59338795ad.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761669531; x=1762274331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BqDKbmFJDAKCoAXMXG6eFztAtsR6ukXq3V60BKqwXHg=;
        b=PB/ldTLCTkYYS98HnXloQ8Eqh/aWkr84s/egDGFMvZ5DHZa3JV9XehvhWp2ki8erfN
         xYWMu5l1SAmAKteMS3KF/0gWR98HKvbcQyrlOzZXJ3olH5XAjjO6/YXuJUsl41AqHT/I
         8VbAKc073Vw+cNDYeLREIOk5HG3VRVaipuf6BWblI2+XL6P1ZNa/Y20x2IGImQhRyRaS
         UPpJuUCvb5HuSa4SbGiZW50hdQyES+bMbvYJedgz1dvVswvWCbADmQ+xoKR2AuVD8epM
         oIS8EROujWZBFBubgpSArjN1di5ZuOKEueSLNaIhHUEB4Up2hEMErTL3ZpUzGlMdScue
         74GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669531; x=1762274331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqDKbmFJDAKCoAXMXG6eFztAtsR6ukXq3V60BKqwXHg=;
        b=uqHPS3YCBNaWE+tMLn51WtoTskbx3lP33qdO5HWFpfAe1kfTdY61/7kCvKbSheQ1Bd
         pahxzQDgsjbdamkhHQ7Zqu5gb+Zvx2bJ1kDJIbunntwUyFNbFo06uk4Ans5daCRtCvce
         1Rko/QiylnxlsHx9yXUioysfzcCyoThe7hF+a3nMOzE0wCJhIcqIoaV5mX2VBbWV3YeN
         w7voNfYQHxa06wXZOLk0UyRzRc4dFzryJhBO/42u6fD+87mIxTPfiuU57xMN9BBsr+L2
         1jifjHVio3U51UcDt+BtlLak6KLxa99eo+R2xNsIA0LIr0rrULLlrduZopLY7W/TgAIY
         AiXA==
X-Forwarded-Encrypted: i=1; AJvYcCVVuZ5K0lwKO+Br0hI6EIRjw96xwSvFFdDWsPykD6Ubv/xQgMyzl3UK22GAsNAdxPx4LcaS5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIsXi5twE0t2q+dHj6PmFphdgBsMHymvFzPIleODSyEjb8YjX
	2W3ANp/BR4MuGsRs/GuAi0MD4xTDZH1KqhquJG1bcAMUinlMLf3JbkSihHThjAD50aQ=
X-Gm-Gg: ASbGnctRmWP3kfGpkCijvHhLrpq6okBh/HknaZflUGxMQ2vevDoBF5A+MC/GmGE9OOh
	Ia/moJ6iGXX45oBVlPhIobiRRqJM8d1MW/6JeBal2tEkOYeRjXjQw3xUj0e+DSacVCn5s6X7/IX
	434ODMrTbd6P59WLcoNCL2KROvMUMq0wxaugbcckC34I2zNj1Rcz/pQQjrq2SMfHoV28Yecr+aM
	w9A9XiMQI4QF8+CR5I0ue8dIbHpzo8qfTaWLrK8nKJE+ZNbBHc32+AXNv1GzJbwfwZqkEzJW8In
	seDcfCF9YPVMBzMn4KS7muajGghMGaQBWFxBI3cV4QKF2ERnJhPDMr246bBR2Z0Qy0p4NSTS+F1
	KVZmvNruuK9jMvpXazzn0j0hUBzB98hfKR5JRQz5flwKAAdG6Me31EWBC5CqVzuvCeQ==
X-Google-Smtp-Source: AGHT+IHhgguP+6o2tx8aSKJb8FENYgmztPkblCCAgO4rRlqiNiK7uHrwdn+DR+NuioAHPbC3T4JinA==
X-Received: by 2002:a17:902:f693:b0:24d:1f99:713a with SMTP id d9443c01a7336-294cb522877mr60919495ad.31.1761669530828;
        Tue, 28 Oct 2025 09:38:50 -0700 (PDT)
Received: from essd ([49.37.217.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm123763155ad.49.2025.10.28.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:38:50 -0700 (PDT)
Date: Tue, 28 Oct 2025 22:08:44 +0530
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: Simon Horman <horms@kernel.org>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] isdn: mISDN: hfcsusb: fix memory leak in
 hfcsusb_probe()
Message-ID: <f2xnihnjrvh6qqqqtqev6zx47pjhxd5kpgdahibdsgtg7ran2d@z6yerx5rddsr>
References: <20251024173458.283837-1-nihaal@cse.iitm.ac.in>
 <aQC333bzOkMNOFAG@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQC333bzOkMNOFAG@horms.kernel.org>

On Tue, Oct 28, 2025 at 12:32:31PM +0000, Simon Horman wrote:
> I agree that this is a bug, and that it was introduced in the cited commit.

Thanks for reviewing the patch.

> I think it would be good to add something to the commit message
> regarding how the problem was found, e.g. which tool was used, or
> by inspection; and what testing has been done, e.g. compile tested only.

Sure I'll add that to future patches that I send.
This issue was reported by a prototype static analysis tool.
And it is compile tested only.

> I think it would be best to follow the idiomatic pattern and
> introduce a ladder of goto statements to handle unwind on error.
> 
> Something like this (compile tested only!):
> 
> diff --git a/drivers/isdn/hardware/mISDN/hfcsusb.c b/drivers/isdn/hardware/mISDN/hfcsusb.c
> @@ -1921,6 +1920,7 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  		probe_alt_setting, vend_idx, cfg_used, *vcf, attr, cfg_found,
>  		ep_addr, cmptbl[16], small_match, iso_packet_size, packet_size,
>  		alt_used = 0;
> +	int err;
>  
>  	vend_idx = 0xffff;
>  	for (i = 0; hfcsusb_idtab[i].idVendor; i++) {
> @@ -2101,20 +2101,28 @@ hfcsusb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	if (!hw->ctrl_urb) {
>  		pr_warn("%s: No memory for control urb\n",
>  			driver_info->vend_name);
> -		kfree(hw);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto err_free_urb;
>  	}
>  
>  	pr_info("%s: %s: detected \"%s\" (%s, if=%d alt=%d)\n",
>  		hw->name, __func__, driver_info->vend_name,
>  		conf_str[small_match], ifnum, alt_used);
>  
> -	if (setup_instance(hw, dev->dev.parent))
> -		return -EIO;
> +	if (setup_instance(hw, dev->dev.parent)) {
> +		err = -EIO;
> +		goto err_free_hw;
> +	}
>  
>  	hw->intf = intf;
>  	usb_set_intfdata(hw->intf, hw);
>  	return 0;
> +
> +err_free_urb:
> +	usb_free_urb(hw->ctrl_urb);
> +err_free_hw:
> +	kfree(hw);
> +	return err;
>  }

In this case, since there are only two memory allocations and only two
error paths involved, I would prefer keeping the frees in place. But I
agree that for longer error paths the ladder of gotos would be better.

Let me know. I can send an updated patch in the goto-ladder style, if
you insist.

Regards,
Nihaal

