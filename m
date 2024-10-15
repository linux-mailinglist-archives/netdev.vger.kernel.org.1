Return-Path: <netdev+bounces-135884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C799F7F7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5B91C21068
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A661B6D04;
	Tue, 15 Oct 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcJTEXMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345531F6697
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 20:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023230; cv=none; b=XsQLRATZUao/DannHxhx4e5tJbfwAC/RFudUKcvy7ODihZkYkuWiRm3oiFkgSXvEaxd5hIr0hTonyZdRWDuhfrKPfjbKCv2pIUq/78TAj2LUt3cIaSgqaAd1oP2RvcRuSbtf0LDMJIuEomR0OfKd1NYxDhDFftVDWcrNWSNifO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023230; c=relaxed/simple;
	bh=xnhNE/uKBe30JUYoFTe7mbiPBoLKaTttvcntrMdzTng=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lOPiat/jwwwdOhKR0vQByPMjTs6MsTXOgBZbogj+iCd6nEqdT1rbqGnAS2lmu2jVBWtWqWAeqaN/CpJ7l+uP1bzmwHPejLAl5aJTrNyaxh/vGkTfdtES9ID3ArwyTRyr3MAJS/MjDx3/fwE6bwX7gHbZohJSxFsT1dSyvqvvRtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcJTEXMf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b113cd6d0aso555707285a.2
        for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729023227; x=1729628027; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q8V43fwBxqew/5Xk6CnF0Jwrx/qc3LvG6VFgBfteRE=;
        b=FcJTEXMfzbazWD4Bij7+N5CdCQ3qRlQA2per0Ls5WLMf7lJBLIS+pkjZxRV0uAB4NQ
         RGe6WObPqAPv9jPpO0JVTWu2IsfQysSCOn10xFfTdbwRG00HjXbhEe/dibKcLZfrDN6A
         zKOu7EWOWrH/fPWwTiqw4A5tf/SqNQClCK7uxnYvASoXYb1lsviz0uBjxncf6t7RmzFD
         4V8acxZl99HrZ66oVF89MHDPyTcmE05bsQO8gk8zewWKSLSSiPwz/DxVG1CxWCe8tJ+n
         moPUdRzAVSA7su/VskpdYLaw8zBwAVW9xs80oIZr2WDQoyLWRXz0/QMDL9fEiUUmWMg5
         ixHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023227; x=1729628027;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Q8V43fwBxqew/5Xk6CnF0Jwrx/qc3LvG6VFgBfteRE=;
        b=P4eofhYeoOF0YKsdQPsWT0MK0ZQdcoah44oAp9ZZcmM1rp+iN/NRpmmTc/ZkhSIlsF
         M7RW13Z6+YNLWub7U2mE06TzQpWk1mmN9P9T5xvpK1IqV0/MmFvzk9AyHCHYgvScGN9Z
         j9ECbDqnRySU7YXkqVfUyctsNyvH3nxat4CBzRYZk5aQMwpJ5zr9bbCD4AMTjOYXji65
         tECmD38XDsbXQNhJlGGDkXgI/IL2hTS+JUyPdt5u0HHanl6fH4UyGqSor0i8hxy0IbDB
         y+JyOqXvo1nk5qb7WL6NtvpX9mxwQWzhTeSmPJMoUma29yoMuwYhdCSz7z7WGANPSjuU
         bz/g==
X-Gm-Message-State: AOJu0YyoN9GLNdB25GEOJU0Psd2DYpOF4UmycW4sb7MEZYPFJgIMmdb2
	y4rxp6L1k2ibOT4wNFpdofIBmMHjtKMaNG78e0lwA99Ep4arwSLMTl5djg==
X-Google-Smtp-Source: AGHT+IG8NxNC/NgDWttuN1Y2hpnQpMwEe/SZ+gdaZFfnMg5lgulywlQPvlOM7E8QXVpr0Aay6pk6cA==
X-Received: by 2002:a05:620a:2454:b0:7ae:5c5b:a3e8 with SMTP id af79cd13be357-7b1417e8442mr179022785a.34.1729023226882;
        Tue, 15 Oct 2024 13:13:46 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:8629:aa69:8faa:971? ([2620:10d:c091:500::6:ed8e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1361661fesm108419085a.11.2024.10.15.13.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 13:13:46 -0700 (PDT)
Message-ID: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
Date: Tue, 15 Oct 2024 16:13:46 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 idosch@nvidia.com, danieller@nvidia.com
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [RFC ethtool] ethtool: mock JSON output for --module-info
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I would like to support json output for the ethtool --module-info 
command. As a first step, I would like to show some real output from a 
CMIS 4.0 compliant transceiver and then propose some mock output for the 
--json version. The general approach is as follows:

1. Byte fields that are currently rendered as hex with a parenthetical 
description get split into two keys: one with a number value, and a 
second key with a "_description" suffix containing the string 
description. This idea is from 
https://lore.kernel.org/all/20220704054114.22582-2-matt@traverse.com.au/
2. Fields that are currently rendered as floating point numbers with 
units get split into two keys: one with the number value, and one with a 
string value showing the units.
3. On/Off is rendered as true/false.
4. yes/no is rendered as true/false.
5. per channel fields are rendered as arrays of boolean. In the sample 
output the module has one bank with 8 total channels.
6. vendor info is displayed as byte arrays.

Here is the original output for ethtool -m <iface> for the CMIS 4.0 module:

Identifier                                : 0x18 (QSFP-DD Double Density 
8X Pluggable Transceiver (INF-8628))
Power class                               : 5
Max power                                 : 10.00W
Connector                                 : 0x0c (MPO Parallel Optic)
Cable assembly length                     : 0.00m
Tx CDR bypass control                     : No
Rx CDR bypass control                     : No
Tx CDR                                    : Yes
Rx CDR                                    : Yes
Transmitter technology                    : 0x06 (1310 nm EML)
Laser wavelength                          : 1311.000nm
Laser wavelength tolerance                : 6.500nm
Length (SMF)                              : 2.00km
Length (OM5)                              : 0m
Length (OM4)                              : 0m
Length (OM3 50/125um)                     : 0m
Length (OM2 50/125um)                     : 0m
Vendor name                               : Arista Networks
Vendor OUI                                : 00:1c:73
Vendor PN                                 : QDD-400G-XDR4
Vendor rev                                : 41
Vendor SN                                 : XKT242211481
Date code                                 : 240531
Revision compliance                       : Rev. 4.0
Rx loss of signal                         : None
Tx loss of signal                         : None
Rx loss of lock                           : None
Tx loss of lock                           : None
Tx fault                                  : None
Module State                              : 0x03 (ModuleReady)
LowPwrAllowRequestHW                      : On
LowPwrRequestSW                           : Off
Module temperature                        : 70.49 degrees C / 158.89 
degrees F
Module voltage                            : 3.2186 V
Laser tx bias current (Channel 1)         : 83.806 mA
Laser tx bias current (Channel 2)         : 81.878 mA
Laser tx bias current (Channel 3)         : 72.900 mA
Laser tx bias current (Channel 4)         : 110.100 mA
Laser tx bias current (Channel 5)         : 0.000 mA
Laser tx bias current (Channel 6)         : 0.000 mA
Laser tx bias current (Channel 7)         : 0.000 mA
Laser tx bias current (Channel 8)         : 0.000 mA
Transmit avg optical power (Channel 1)    : 1.5975 mW / 2.03 dBm
Transmit avg optical power (Channel 2)    : 1.6486 mW / 2.17 dBm
Transmit avg optical power (Channel 3)    : 1.6333 mW / 2.13 dBm
Transmit avg optical power (Channel 4)    : 1.4387 mW / 1.58 dBm
Transmit avg optical power (Channel 5)    : 0.0000 mW / -inf dBm
Transmit avg optical power (Channel 6)    : 0.0000 mW / -inf dBm
Transmit avg optical power (Channel 7)    : 0.0000 mW / -inf dBm
Transmit avg optical power (Channel 8)    : 0.0000 mW / -inf dBm
Rcvr signal avg optical power (Channel 1) : 2.2489 mW / 3.52 dBm
Rcvr signal avg optical power (Channel 2) : 1.8629 mW / 2.70 dBm
Rcvr signal avg optical power (Channel 3) : 1.8427 mW / 2.65 dBm
Rcvr signal avg optical power (Channel 4) : 1.8215 mW / 2.60 dBm
Rcvr signal avg optical power (Channel 5) : 0.0000 mW / -inf dBm
Rcvr signal avg optical power (Channel 6) : 0.0000 mW / -inf dBm
Rcvr signal avg optical power (Channel 7) : 0.0000 mW / -inf dBm
Rcvr signal avg optical power (Channel 8) : 0.0000 mW / -inf dBm
Module temperature high alarm             : Off
Module temperature low alarm              : Off
Module temperature high warning           : On
Module temperature low warning            : Off
Module voltage high alarm                 : Off
Module voltage low alarm                  : Off
Module voltage high warning               : Off
Module voltage low warning                : Off
Laser bias current high alarm   (Chan 1)  : Off
Laser bias current low alarm    (Chan 1)  : Off
Laser bias current high warning (Chan 1)  : Off
Laser bias current low warning  (Chan 1)  : Off
Laser tx power high alarm   (Channel 1)   : Off
Laser tx power low alarm    (Channel 1)   : Off
Laser tx power high warning (Channel 1)   : Off
Laser tx power low warning  (Channel 1)   : Off
Laser rx power high alarm   (Channel 1)   : Off
Laser rx power low alarm    (Channel 1)   : Off
Laser rx power high warning (Channel 1)   : Off
Laser rx power low warning  (Channel 1)   : Off
Laser bias current high alarm   (Chan 2)  : Off
Laser bias current low alarm    (Chan 2)  : Off
Laser bias current high warning (Chan 2)  : Off
Laser bias current low warning  (Chan 2)  : Off
Laser tx power high alarm   (Channel 2)   : Off
Laser tx power low alarm    (Channel 2)   : Off
Laser tx power high warning (Channel 2)   : Off
Laser tx power low warning  (Channel 2)   : Off
Laser rx power high alarm   (Channel 2)   : Off
Laser rx power low alarm    (Channel 2)   : Off
Laser rx power high warning (Channel 2)   : Off
Laser rx power low warning  (Channel 2)   : Off
Laser bias current high alarm   (Chan 3)  : Off
Laser bias current low alarm    (Chan 3)  : Off
Laser bias current high warning (Chan 3)  : Off
Laser bias current low warning  (Chan 3)  : Off
Laser tx power high alarm   (Channel 3)   : Off
Laser tx power low alarm    (Channel 3)   : Off
Laser tx power high warning (Channel 3)   : Off
Laser tx power low warning  (Channel 3)   : Off
Laser rx power high alarm   (Channel 3)   : Off
Laser rx power low alarm    (Channel 3)   : Off
Laser rx power high warning (Channel 3)   : Off
Laser rx power low warning  (Channel 3)   : Off
Laser bias current high alarm   (Chan 4)  : Off
Laser bias current low alarm    (Chan 4)  : Off
Laser bias current high warning (Chan 4)  : Off
Laser bias current low warning  (Chan 4)  : Off
Laser tx power high alarm   (Channel 4)   : Off
Laser tx power low alarm    (Channel 4)   : Off
Laser tx power high warning (Channel 4)   : Off
Laser tx power low warning  (Channel 4)   : Off
Laser rx power high alarm   (Channel 4)   : Off
Laser rx power low alarm    (Channel 4)   : Off
Laser rx power high warning (Channel 4)   : Off
Laser rx power low warning  (Channel 4)   : Off
Laser bias current high alarm   (Chan 5)  : Off
Laser bias current low alarm    (Chan 5)  : Off
Laser bias current high warning (Chan 5)  : Off
Laser bias current low warning  (Chan 5)  : Off
Laser tx power high alarm   (Channel 5)   : Off
Laser tx power low alarm    (Channel 5)   : Off
Laser tx power high warning (Channel 5)   : Off
Laser tx power low warning  (Channel 5)   : Off
Laser rx power high alarm   (Channel 5)   : Off
Laser rx power low alarm    (Channel 5)   : Off
Laser rx power high warning (Channel 5)   : Off
Laser rx power low warning  (Channel 5)   : Off
Laser bias current high alarm   (Chan 6)  : Off
Laser bias current low alarm    (Chan 6)  : Off
Laser bias current high warning (Chan 6)  : Off
Laser bias current low warning  (Chan 6)  : Off
Laser tx power high alarm   (Channel 6)   : Off
Laser tx power low alarm    (Channel 6)   : Off
Laser tx power high warning (Channel 6)   : Off
Laser tx power low warning  (Channel 6)   : Off
Laser rx power high alarm   (Channel 6)   : Off
Laser rx power low alarm    (Channel 6)   : Off
Laser rx power high warning (Channel 6)   : Off
Laser rx power low warning  (Channel 6)   : Off
Laser bias current high alarm   (Chan 7)  : Off
Laser bias current low alarm    (Chan 7)  : Off
Laser bias current high warning (Chan 7)  : Off
Laser bias current low warning  (Chan 7)  : Off
Laser tx power high alarm   (Channel 7)   : Off
Laser tx power low alarm    (Channel 7)   : Off
Laser tx power high warning (Channel 7)   : Off
Laser tx power low warning  (Channel 7)   : Off
Laser rx power high alarm   (Channel 7)   : Off
Laser rx power low alarm    (Channel 7)   : Off
Laser rx power high warning (Channel 7)   : Off
Laser rx power low warning  (Channel 7)   : Off
Laser bias current high alarm   (Chan 8)  : Off
Laser bias current low alarm    (Chan 8)  : Off
Laser bias current high warning (Chan 8)  : Off
Laser bias current low warning  (Chan 8)  : Off
Laser tx power high alarm   (Channel 8)   : Off
Laser tx power low alarm    (Channel 8)   : Off
Laser tx power high warning (Channel 8)   : Off
Laser tx power low warning  (Channel 8)   : Off
Laser rx power high alarm   (Channel 8)   : Off
Laser rx power low alarm    (Channel 8)   : Off
Laser rx power high warning (Channel 8)   : Off
Laser rx power low warning  (Channel 8)   : Off
Laser bias current high alarm threshold   : 130.000 mA
Laser bias current low alarm threshold    : 10.000 mA
Laser bias current high warning threshold : 125.000 mA
Laser bias current low warning threshold  : 15.000 mA
Laser output power high alarm threshold   : 3.5481 mW / 5.50 dBm
Laser output power low alarm threshold    : 0.4074 mW / -3.90 dBm
Laser output power high warning threshold : 2.8184 mW / 4.50 dBm
Laser output power low warning threshold  : 0.5129 mW / -2.90 dBm
Module temperature high alarm threshold   : 75.00 degrees C / 167.00 
degrees F
Module temperature low alarm threshold    : -5.00 degrees C / 23.00 
degrees F
Module temperature high warning threshold : 70.00 degrees C / 158.00 
degrees F
Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
Module voltage high alarm threshold       : 3.6300 V
Module voltage low alarm threshold        : 3.0500 V
Module voltage high warning threshold     : 3.4650 V
Module voltage low warning threshold      : 3.1350 V
Laser rx power high alarm threshold       : 3.5481 mW / 5.50 dBm
Laser rx power low alarm threshold        : 0.1288 mW / -8.90 dBm
Laser rx power high warning threshold     : 2.8184 mW / 4.50 dBm
Laser rx power low warning threshold      : 0.2042 mW / -6.90 dBm

Now the output rendered into json i.e. for ethtool --json -m <iface>

[ {
     "identifier": 11,
     "identifier_description": "QSFP28",
     "power_class": 5,
     "max_power" : 10.00,
     "max_power_units" : "W",
     "connector" : 12,
     "connector_description" : "MPO Parallel Optic",
     "cable_assembly_length" : 0.00,
     "cable_assembly_length_units" : "m",
     "tx_cdr_bypass_control" : false,
     "rx_cdr_bypass_control" : false,
     "tx_cdr" : true,
     "rx_cdr" : true,
     "transmitter_technology" : 6,
     "transmitter_technology_description" : "1310 nm EML",
     "laser_wavelength" : 1311.000,
     "laser_wavelength_units" : "nm",
     "laser_wavelength_tolerance" : 6.500,
     "laser_wavelength_tolerance_units" : "nm",
     "length_smf" : 2.00,
     "length_smf_units" : "km",
     "length_om5" : 0,
     "length_om4" : 0,
     "length_om3" : 0,
     "length_om2" : 0,
     "length_om_units" : "m",
     "vendor_name" : [65, 114, 105, 115, 116, 97, 32, 78, 101, 116, 119, 
111, 114, 107, 115, 32],
     "vendor_oui" : [0, 28, 115],
     "vendor_pn" : [81, 68, 68, 45, 52, 48, 48, 71, 45, 88, 68, 82, 52],
     "vendor_rev" : [4, 1],
     "vendor_sn" : [88, 75, 84, 50, 52, 50, 50, 49, 49, 52, 56, 49],
     "date_code" : [50, 52, 48, 53, 51, 49],
     "revision_compliance" : 48,
     "rx_loss_of_signal" : [false, false, false, false, false, false, 
false, false],
     "tx_loss_of_signal" : [false, false, false, false, false, false, 
false, false],
     "rx_loss_of_lock" : [false, false, false, false, false, false, 
false, false],
     "tx_loss_of_lock" : [false, false, false, false, false, false, 
false, false],
     "tx_fault" : [false, false, false, false, false, false, false, false],
     "module_state" : 3,
     "module_state_description" : "ModuleReady",
     "low_pwr_allow_request_hw": true,
     "low_pwr_request_sw": false,
     "module_temperature" : 70.49,
     "module_temperature_units" : "C",
     "module_voltage" : 3.2186,
     "module_voltage_units" : "V",
     "laser_tx_bias_current" : [83.806, 81.878, 72.900, 110.100, 0, 0, 
0, 0],
     "laser_tx_bias_current_units" : "mA",
     "transmit_avg_optical_power" : [1.5975, 1.6486, 1.6333, 1.4387, 0, 
0, 0, 0],
     "transmit_avg_optical_power_units" : "mW",
     "rcvr_signal_avg_optical_power" : [2.2489, 1.8629, 1.8427, 1.8215, 
0, 0, 0, 0],
     "rcvr_signal_avg_optical_power_units" : "mW",
     "module_temperature_high_alarm" : false,
     "module_temperature_low_alarm" : false,
     "module_temperature_high_warning" : true,
     "module_temperature_low_warning" : false,
     "module_voltage_high_alarm" : false,
     "module_voltage_low_alarm" : false,
     "module_voltage_high_warning" : false,
     "module_voltage_low_warning" : false,
     "lazer_bias_current_high_alarm" : [false, false, false, false, 
false, false, false, false],
     "lazer_bias_current_low_alarm" : [false, false, false, false, 
false, false, false, false],
     "lazer_bias_current_high_warning" : [false, false, false, false, 
false, false, false, false],
     "lazer_bias_current_low_warning" : [false, false, false, false, 
false, false, false, false],
     "lazer_tx_power_high_alarm" : [false, false, false, false, false, 
false, false, false],
     "lazer_tx_power_low_alarm" : [false, false, false, false, false, 
false, false, false],
     "lazer_tx_power_high_warning" : [false, false, false, false, false, 
false, false, false],
     "lazer_tx_power_low_warning" : [false, false, false, false, false, 
false, false, false],
     "lazer_rx_power_high_alarm" : [false, false, false, false, false, 
false, false, false],
     "lazer_rx_power_low_alarm" : [false, false, false, false, false, 
false, false, false],
     "lazer_rx_power_high_warning" : [false, false, false, false, false, 
false, false, false],
     "lazer_rx_power_low_warning" : [false, false, false, false, false, 
false, false, false],
     "lazer_bias_current_high_alarm_threshold" : 130.000,
     "lazer_bias_current_low_alarm_threshold" : 10.000,
     "lazer_bias_current_high_warning_threshold" : 125.000,
     "lazer_bias_current_low_warning_threshold" : 15.000,
     "lazer_bias_current_alarm_warning_units" : "mA",
     "lazer_output_power_high_alarm_threshold" : 3.5481,
     "lazer_output_power_low_alarm_threshold" : 0.4074,
     "lazer_output_power_high_warning_threshold" : 2.8184,
     "lazer_output_power_low_warning_threshold" : 0.5129,
     "lazer_output_power_warning_alarm_units" : "mW",
     "module_temperature_high_alarm_threshold" : 75.00,
     "module_temperature_low_alarm_threshold" : -5.00,
     "module_temperature_high_warning_threshold" : 70.00,
     "module_temperature_low_warning_threshold" : 0.00,
     "module_temperature_warning_alarm_units" : "C",
     "module_voltage_high_alarm_threshold" : 3.6300,
     "module_voltage_low_alarm_threshold" : 3.0500,
     "module_voltage_high_warning_threshold" : 3.4650,
     "module_voltage_low_warning_threshold" : 3.1350,
     "module_voltage_warning_alarm_units" : "V",
     "lazer_rx_power_high_alarm_threshold" : 3.5481,
     "lazer_rx_power_low_alarm_threshold" : 0.1288,
     "lazer_rx_power_high_warning_threshold" : 2.8184,
     "lazer_rx_power_low_warning_threshold" : 0.2042,
     "lazer_rx_power_warning_alarm_units" : "mW",
     } ]


