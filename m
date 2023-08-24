Return-Path: <netdev+bounces-30472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44784787812
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2939280157
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9301134A1;
	Thu, 24 Aug 2023 18:36:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA4CA76
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 18:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D45C433C8;
	Thu, 24 Aug 2023 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692902198;
	bh=54RR5HEt4NRZ+LMzvy1AprSDd8pbmrH+Y+aTS6x2Tkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGnJuwHbKlzYpqRUV+slZhpwelCK/Bov03qUkxk4mrjmjR8oIAzhVn4glAc1dF8xi
	 sQBnEXd204anhiLm8VsNj/uAipAykx9SJsqCrwKfF52/iIVrDq4yWHhikPXvOrKgSZ
	 WQVM591+OTQXLn0m3u7WraUS0ieAHMXxo7pxutIkQ8S3Qw7NAt+gHSuGlpWntZ8Qki
	 QjKgThKu1rMdw5PlgPhT42C0w9EN/ijMcp4Hp93iqevn5QzU9ECkL6PJuwZWcixTRW
	 JOIW3s4Epfh2h0E1KWoXpag5kILwnXo/JsqzYiCcVg2XAaPyHpiqzYNP298Flwy9IP
	 wQazn+/4HQ80Q==
Date: Thu, 24 Aug 2023 11:36:37 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz
 RSS hash function
Message-ID: <ZOejNYJgR74JGRse@x130>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
 <ZOZhzYExHgnSBej4@x130>
 <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94d9c857-2c2b-77f0-9b17-8088068eee6d@intel.com>

On 24 Aug 07:14, Ahmed Zaki wrote:
>
>On 2023-08-23 13:45, Saeed Mahameed wrote:
>>On 23 Aug 10:48, Ahmed Zaki wrote:
>>>Symmetric RSS hash functions are beneficial in applications that monitor
>>>both Tx and Rx packets of the same flow (IDS, software firewalls, 
>>>..etc).
>>>Getting all traffic of the same flow on the same RX queue results in
>>>higher CPU cache efficiency.
>>>

...

>>
>>What is the expectation of the symmetric toeplitz hash, how do you 
>>achieve
>>that? by sorting packet fields? which fields?
>>
>>Can you please provide a link to documentation/spec?
>>We should make sure all vendors agree on implementation and 
>>expectation of
>>the symmetric hash function.
>
>The way the Intel NICs are achieving this hash symmetry is by XORing 
>the source and destination values of the IP and L4 ports and then 
>feeding these values to the regular Toeplitz (in-tree) hash algorithm.
>
>For example, for UDP/IPv4, the input fields for the Toeplitz hash would be:
>
>(SRC_IP, DST_IP, SRC_PORT,  DST_PORT)
>

So you mangle the input. This is different than the paper you
referenced below which doesn't change the input but it modifies the RSS
algorithm and uses a special hash key.

>If symmetric Toeplitz is set, the NIC XOR the src and dst fields:
>
>(SRC_IP^DST_IP ,  SRC_IP^DST_IP, SRC_PORT^DST_PORT, SRC_PORT^DST_PORT)
>
>This way, the output hash would be the same for both flow directions. 
>Same is applicable for IPv6, TCP and SCTP.
>

I understand the motivation, I just want to make sure the interpretation is
clear, I agree with Jakub, we should use a clear name for the ethtool
parameter or allow users to select "xor-ed"/"sorted" fields as Jakub
suggested.

>Regarding the documentation, the above is available in our public 
>datasheets [2]. In the final version, I can add similar explanation in 
>the headers (kdoc) and under "Documentation/networking/" so that there 
>is a clear understanding of the algorithm.
>
>
>[1] https://www.ndsl.kaist.edu/~kyoungsoo/papers/TR-symRSS.pdf
>
>[2] E810 datasheet: 7.10.10.2 : Symmetric Hash
>
>https://www.intel.com/content/www/us/en/content-details/613875/intel-ethernet-controller-e810-datasheet.html
>

This document doesn't mention anything about implementation.


