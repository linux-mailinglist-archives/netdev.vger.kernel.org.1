Return-Path: <netdev+bounces-199379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF54AE002A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849C57AEC8F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462B264A7A;
	Thu, 19 Jun 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mcap2uCs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638F238159
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322695; cv=none; b=UrpOzg8JpfD32xQhnXNyRrAeGGgwSHIN3D+CV1jIMGP9yJMe/NESpccVwoRtd/Io8pBVLXsG5y55mZyZOU29EK+ryzJM2oiUs6w5X4imJZGTVtuSvRW9+bms/cq3rVVEGbaLIchIRH8vMwBFGrEblAnspUy7ekGy3F7WlBz3r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322695; c=relaxed/simple;
	bh=rk/IpXu0qPggN3PyPhpYiaIak+3MbFIy34A+7jUgTnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otQ1k+8qMHUTzObRt54WsJcsftKYcBFRPrnIFWkuCUjglYMM93G57jYQ0cDQR54YEMnYVTNwLZ1bracrLnS8pttnRK4EQHjRYRNEm1sF2svDtRkA+XS4T1HUtzPKyFhjwcHyvl5hpguS5l09Y8ajG+fefV5rJQ0XogZFyXqqG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mcap2uCs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750322691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPXrRXdTBzvvDNKQDCvDE2CiNt7Sgpl7XvX4qo2Zg+g=;
	b=Mcap2uCsXfHnkTVlFRMOXzaZg3E0F9kSo/Rsvoyq+m2clcR1JJRBtn8WB4DTjo/hBZLDR1
	5vTjQ3wknuhcOVMIT4tnGjvJtGZvptlg3B/Rj1CvARLSwUeGBjn/pu8Wo5XfOuWUgGtWsV
	V7aKg9j03Y5xDkdUmJPI/QIs42cfMV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-GE_VKCnZP-2k4sBAU8N2cg-1; Thu, 19 Jun 2025 04:44:48 -0400
X-MC-Unique: GE_VKCnZP-2k4sBAU8N2cg-1
X-Mimecast-MFC-AGG-ID: GE_VKCnZP-2k4sBAU8N2cg_1750322685
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso293054f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 01:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750322685; x=1750927485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPXrRXdTBzvvDNKQDCvDE2CiNt7Sgpl7XvX4qo2Zg+g=;
        b=XPDZzy842qH20CONYEekMxTmMw6SVApuqxRk0KXyibTiRY75dDRzAiEHGXyOQ8cTSf
         UxFDYeZK9MHHg7uItKBfRHzcp4vu+JXvER4nK7+aLC48auRqvnPHcW+Y7y8xwJK0jFZ4
         m0WLeATpTNXJ7R+0M967T+xAr3bDNEbOsVZv6Q53Q4hWIiBzR4NhDSNnOgDx7UggoVYL
         bvLzJ57CMArSzLApMt4TRlvloWbA6kPAzw8ahikemX8OmaF9qP6IV8p9VIGQ8Ou/4pLG
         rEWjfpMr+57FRiFSPeYounAEDwN7JR1gbMe9OiDR3sFjoHnhW7ewerKjY6gAhH+bnoUn
         uX8g==
X-Forwarded-Encrypted: i=1; AJvYcCUU69qcBzLoxrTT8YODa7R7IZX1/nA9PDtARwrKTTtbwV5diA8eIzktaxWppS1sC5gQImfBdQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fXuoZFPndMgFC5OmWabIFHxlg7SHoOcsT8kz4euiqJg7OGtQ
	s7e9DaaVUN4Od1QQohtMpyTL4jXt5ajBMj8uk+0PVSKhZDotwhGoFrpeOo4oY7G19Nhe7RbXuRF
	5qTUzXZYb8pbpPTuQepSn6yu8sVWxENExUsuzUIXU0pvxX0sns2efpYVcCQ==
X-Gm-Gg: ASbGncvJ8VO7BhNIUc8h7RXZL3yRiip13TKjpElAQ3cMOW0Euu/qkY1zPVJ23DnTl0H
	1cLy+tKbNnqk/LU4jFSc/NZzaGv2d39Lk8rEjQOsAwz6p/wDf/hCcmwFyJl5ietAkE6+18J4Q7F
	78GUq3u7eYqGxvl9kDyAKpOKa/VMnM6iFgIRGzXnPy0x24E4iNBzeSCL9rnMkGWESEHEJ63ldz2
	81FshCY8eECikUNrTkBEqkb7mTuQn3tdJu8UcRebuQx0xHvGhayOUN+yhSP2CkR+V3aLbwMfwcM
	eXSRGduaLpu1QzUGL0tV/DQiKgG0/HfAUJ7aBCuAVaHPb2SNV+MpoF2nneE1iyqTWgvlRw==
X-Received: by 2002:a5d:5c0f:0:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3a57238b99amr14488159f8f.3.1750322685042;
        Thu, 19 Jun 2025 01:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFNK6MMJP08itYkEccrwwGWBE5Zy5NOpIZ11EeuIoN4ndfpZ3rwW9+8uYuAqtSSMwTDEPQkw==
X-Received: by 2002:a5d:5c0f:0:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3a57238b99amr14488137f8f.3.1750322684561;
        Thu, 19 Jun 2025 01:44:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm21612315e9.40.2025.06.19.01.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 01:44:43 -0700 (PDT)
Message-ID: <5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
Date: Thu, 19 Jun 2025 10:44:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 0/8] Add support for 25G, 50G, and 100G to
 fbnic
To: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org, kernel-team@meta.com,
 edumazet@google.com
References: <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 12:07 AM, Alexander Duyck wrote:
> The fbnic driver up till now had avoided actually reporting link as the
> phylink setup only supported up to 40G configurations. This changeset is
> meant to start addressing that by adding support for 50G and 100G interface
> types.
> 
> With that basic support added fbnic can then set those types based on the
> EEPROM configuration provided by the firmware and then report those speeds
> out using the information provided via the phylink call for getting the
> link ksettings. This provides the basic MAC support and enables supporting
> the speeds as well as configuring flow control.
> 
> After this I plan to add support for a PHY that will represent the SerDes
> PHY being used to manage the link as we need a way to indicate link
> training into phylink to prevent link flaps on the PCS while the SerDes is
> in training, and then after that I will look at rolling support for our
> PCS/PMA into the XPCS driver.

Apparently this is causing TSO tests failures:

# ok 1 tso.ipv4
# # Testing with mangleid enabled
# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 160, in f:
# # Check|     run_one_stream(cfg, ipver, remote_v4, remote_v6,
# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 80, in run_one_stream:
# # Check|     ksft_ge(qstat_new['tx-hw-gso-wire-packets'] -
# # Check failed 0 < 2516.0 Number of LSO wire-packets with LSO enabled
# not ok 2 tso.vxlan4_ipv4
# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 160, in f:
# # Check|     run_one_stream(cfg, ipver, remote_v4, remote_v6,
# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 80, in run_one_stream:
# # Check|     ksft_ge(qstat_new['tx-hw-gso-wire-packets'] -
# # Check failed 0 < 2516.0 Number of LSO wire-packets with LSO enabled
# not ok 3 tso.vxlan4_ipv6

And vlxlan TSO, too:

# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 154, in f:
# # Check|     run_one_stream(cfg, ipver, remote_v4, remote_v6,
should_lso=False)
# # Check| At
/home/virtme/testing-24/tools/testing/selftests/drivers/net/hw/./tso.py,
line 65, in run_one_stream:
# # Check|     ksft_lt(tcp_sock_get_retrans(sock), 10)
# # Check failed 10 >= 10
# not ok 10 tso.vxlan6_ipv6

I'm tentatively/blindly removing this from the PW queue to double check
the assumption.

/P


