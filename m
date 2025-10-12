Return-Path: <netdev+bounces-228651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF81BD0D4E
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 00:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B1E3BAEBA
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 22:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEE821D596;
	Sun, 12 Oct 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo2RQv8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9738156CA
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 22:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760309725; cv=none; b=jyyLoN73rn9Dyr0BUXEGHB1rzkrP2tAqeWO+pYNZk3qMNvLfWWHcMudffNkjnua/BrWmGhW2TSgTaHIAyf1DG7PLHE4/cVKyU8wr4c5+WqFfDU8eOuvvnOTnjqgicbU4y2DFgkWmBGrUa5ByBCXCQJCFzOOfv6xOLS84oaO4bko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760309725; c=relaxed/simple;
	bh=/aNugIRUK+tpxRbJgf7i0oPPZTjKelZlkgsPkBZfXKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H88G00CXIZy8svzaYS1Tem6rW3rGg82bdtId1UJRX08IdM4wBMv3DHbfNay/TOhwCaELjVqrYlehXytaovGcqeJtwqVOb2nfOwUkaQ7G4toCefwz4krLYLIf/g+u+ZX8VVF4OiR7lOv6StWPQu0cRoT+zliW6c5ujtTN1+59l8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo2RQv8K; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e5980471eso18432625e9.2
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760309722; x=1760914522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga3oYxy9UQThMlPgmNDPkN9ZAYPBeMGO+WE4XySet1w=;
        b=mo2RQv8K+kYC9Inq2nxfhBjwDFKwNJAxpoGzYLy1GPCZMymOzdbc+19nSrCyW9dTi2
         WwSIHcpCK6Ex++GlndY/B+CERuzqWViDFLKK3li2ipIhilrp2bli1VCkmjfy6cUpEHtL
         pnyXzATwRqrrJqZinUt4zdVTuXJvLALsYUXXBI+spgN7KRcUj6zmoO9ZyecwDv5Vh57m
         mFlRm7edfbniVpbXZRajkx9lxc1QZ6u/dyD+S9VJWzpRHTbfNf9wbmsAw8G9OmdEIwyD
         MjzcVotaF5uymeRxSHYjovIWbicGl9ZD5o9MDZXR+iQ2SwOzebg1aFN2+vOUSxxZU6/E
         ZYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760309722; x=1760914522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga3oYxy9UQThMlPgmNDPkN9ZAYPBeMGO+WE4XySet1w=;
        b=f8bIsH+DvTz0vmzHWm75195/Zsqs4b0paYYPkVMGQPMZHNTzZrnmT707cxNsjIj9VE
         anI0Hpi4fS8ygxuGCB5KSCSJrioxAGltBnqCjY0U/0HAAFmw4i8L5y/cpFeMtH8KbyRG
         YID9XgLfjVoNRMX+LEU9RjRPImddR4Cglyn82vzt6sZYiatQaV2CW3s33nGViv357EIk
         5Tki8ngYT4fFq8uqT5XZziLli5ngaeUJEcxnMlodIwoQYXPtGdQK5TI8nH4g6xQrm114
         IYN5NnDbmVZoc78ngwmS4iCUF0/Hu8A/y488/mE+IdZsK9ovwoE+V+Fbtmi6qTDSOhI5
         Y0SA==
X-Forwarded-Encrypted: i=1; AJvYcCVde6WuyB8BBdy2KBfFqj2wcM74HcFg3kIY1qTQtOwsW+zojK6BgMtfM9kA1dN8fRkDfN1dAwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbsV8pROt5aI0zmJKq2kftdT+xCD2n1JUlkXg6fQwPA3DPhNHv
	YeeWlZI6CfNv8c1zluo7I2LLZVVYsHiSvN8bYJ8zLN/c1SHkG3QCnNUF
X-Gm-Gg: ASbGncvaBOxXO9l6S65B49XwcI5Pa/+97V5UuXoBKnOO6kSDDCvtrNIpaQP51uavyys
	LUp/ZHTfiRuS6A5EjL8hOnejSLznEapKOFOmkEsQo1C+QOq0t1uapGSUit4mMJjdtENkdM1M/mk
	VyQkLHWLA9Kk/uPcaKLWS9ZCqfhYmLgURI630zCKcXyomO4pWiwdxmCeMvQUpoeWMP8LO4h0xH8
	Bm5wpJZp86vM0IpIiM168ateE/2VDSX8orHQ2nEJ9DFkY/nS5YmDwVlOMU2xbCfiVg8bq4zUgoR
	OeBz8lQJ1H12Mo9VxggKVdpS4vvW8AIlpJTrFsyFddBd6hbShrXwocEqjwzweH2QcXa+EbS+n9Z
	GtVMFlVl5cd9gXfoeRG12VwH8CqN3XKXQe3KJ11rxnfNEP4CSgMzjCb5XP41nraNDBQ==
X-Google-Smtp-Source: AGHT+IFntJSUYtRCPK7KavGvKy5wVQkw0dAhrB3ptNAqvEQRke4kEmv88hozJjUx5+qyTb94kmyFNg==
X-Received: by 2002:a5d:5d08:0:b0:3fe:4fa2:8cdc with SMTP id ffacd0b85a97d-4266e8e6dd8mr12989064f8f.60.1760309721703;
        Sun, 12 Oct 2025 15:55:21 -0700 (PDT)
Received: from [192.168.0.4] ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57cc0esm15261512f8f.6.2025.10.12.15.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 15:55:19 -0700 (PDT)
Message-ID: <90747682-22c6-4cb6-a6d1-3bef4aeab70e@gmail.com>
Date: Mon, 13 Oct 2025 01:55:28 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Daniele Palmas <dnlplm@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Slark Xiao <slark_xiao@163.com>, Muhammad Nuzaihan <zaihan@unrealasia.net>,
 Johannes Berg <johannes@sipsolutions.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Qiang Yu <quic_qianyu@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Johan Hovold <johan@kernel.org>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com>
 <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com>
 <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com>
 <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
 <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com>
 <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniele,

On 10/10/25 16:47, Daniele Palmas wrote:
> Il giorno mer 8 ott 2025 alle ore 23:00 Sergey Ryazanov
> <ryazanov.s.a@gmail.com> ha scritto:
>> On 10/2/25 18:44, Loic Poulain wrote:
>>> On Tue, Sep 30, 2025 at 9:22 AM Daniele Palmas <dnlplm@gmail.com> wrote:
>>> [...]
>>>> diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
>>>> index a748b3ea1602..e4b1bbff9af2 100644
>>>> --- a/drivers/net/wwan/wwan_hwsim.c
>>>> +++ b/drivers/net/wwan/wwan_hwsim.c
>>>> @@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct timer_list *t)
>>>>           /* 43.74754722298909 N 11.25759835922875 E in DMM format */
>>>>           static const unsigned int coord[4 * 2] = { 43, 44, 8528, 0,
>>>>                                                      11, 15, 4559, 0 };
>>>> -       struct wwan_hwsim_port *port = from_timer(port, t, nmea_emul.timer);
>>>> +       struct wwan_hwsim_port *port = timer_container_of(port, t,
>>>> nmea_emul.timer);
>>>>
>>>> it's basically working fine in operative mode though there's an issue
>>>> at the host shutdown, not able to properly terminate.
>>>>
>>>> Unfortunately I was not able to gather useful text logs besides the picture at
>>>>
>>>> https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/view?usp=sharing
>>>>
>>>> showing an oops with the following call stack:
>>>>
>>>> __simple_recursive_removal
>>>> preempt_count_add
>>>> __pfx_remove_one
>>>> wwan_remove_port
>>>> mhi_wwan_ctrl_remove
>>>> mhi_driver_remove
>>>> device_remove
>>>> device_del
>>>>
>>>> but the issue is systematic. Any idea?
>>>>
>>>> At the moment I don't have the time to debug this deeper, I don't even
>>>> exclude the chance that it could be somehow related to the modem. I
>>>> would like to further look at this, but I'm not sure exactly when I
>>>> can....
>>>
>>> Thanks a lot for testing, Sergey, do you know what is wrong with port removal?
>>
>> Daniele, thanks a lot for verifying the proposal on a real hardware and
>> sharing the build fix.
>>
>> Unfortunately, I unable to reproduce the crash. I have tried multiple
>> times to reboot a VM running the simulator module even with opened GNSS
>> device. No luck. It reboots and shutdowns smoothly.
>>
> 
> I've probably figured out what's happening.
> 
> The problem seems that the gnss device is not considered a wwan_child
> by is_wwan_child and this makes device_unregister in wwan_remove_dev
> to be called twice.
> 
> For testing I've overwritten the gnss device class with the following hack:
> 
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 4d29fb8c16b8..32b3f7c4a402 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -599,6 +599,7 @@ static int wwan_port_register_gnss(struct wwan_port *port)
>                  gnss_put_device(gdev);
>                  return err;
>          }
> +       gdev->dev.class = &wwan_class;
> 
>          dev_info(&wwandev->dev, "port %s attached\n", dev_name(&gdev->dev));
> 
> and now the system powers off without issues.
> 
> So, not sure how to fix it properly, but at least does the analysis
> make sense to you?

Nice catch! I had a doubt regarding correct child port detection. Let me 
double check, and thank you for pointing me to the possible source of 
issues.

--
Sergey

