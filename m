Return-Path: <netdev+bounces-204102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92165AF8EB3
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E3217DB83
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883B62BF005;
	Fri,  4 Jul 2025 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rz1AAnh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB5B2BEFF0
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621525; cv=none; b=UV/S+emhZwMSTFR4zH+eyyuD3Vbtc6MXO5GLsmiT8U0v72Cb7b1FDG1B+xdFnaAm7QYwlRCjTv2rph169rEuevvJbACzVctsrRY40fvzq5A0uaZ2Uvz5iZdNrRhDEF2fiXaTHlu+2lba4Omds948/e8gms9Qymsw/ganEsChSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621525; c=relaxed/simple;
	bh=wftsqcCtcQX/OPaM4L8u8Mdr1DIPfeT8N+mox9qB0eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFGBTsYy26kt5ZeRihkXWa7gB9oAACEyMxf1UVUdCWfJ6Dml1twNjtQ4LrVybsXrq4MK4M0oE093rrcyIpC15SC0WBG5ADFJiIWskMPu3ZkTZAUNMqJZQwlaZbqcAKh2EDzpYcTdypSgeFZV4Qi4MHYEoCkaW+4uBLeezY4Wx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rz1AAnh6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so594301f8f.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1751621521; x=1752226321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZgpnBD4GxElwBB/VJGim3bFog8ZZPW72uSDh2Py1og=;
        b=rz1AAnh65kT+M6AV2ZDPxNPrXg2QzleXRjZG0YtSVNdbeBCVzTLHNbQicyPkYeUz8r
         tAzsDI6xJVldpWETW76RNGLKdXESRNTHUfuSs3VHiRup6eT1MVmB/j7BH5S5k8F6I2qY
         QbbRyA9Hn2eM/e+YkKBjf5vqYaHaeyLkVhpyfsfnEvlG2wyKBLDUxntRN0yXXO8q3zhv
         /m8lfu4e4HSimb9eO4TFC6JeFcA1eDxjtzDezKoUpA1BMkO94RfB2qa+/uEbFqQ5Fg4l
         5lFyrm0IhudCstZFysUeFR1TPSt20H7hRn7y3+GoOKpdPqR8eI637RDvsDopZ8nHL25L
         7nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751621521; x=1752226321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZgpnBD4GxElwBB/VJGim3bFog8ZZPW72uSDh2Py1og=;
        b=KhKAJG2PQ2Z748WbeG2GuwaCjggLX0r34lXkFDUaspT5oowVrofWZH9QMePZZTLIJ6
         V7sQFLxqnXs+v3KReUIptEp8B9ViXiir3sH0n6O2z0ThxNWqcb/Tafa3caTb6mOkXifn
         cKoRP3FY8V07ZvsWmbF8l9sRhk9y+XZuWuqC+vD32yvRU+h6RMTxlKCvCaaisrBFM5Td
         2QlNL+gGC4c2IeEzU0XAfHLsPkR04oDMIfdJyWYzhoisU4aAWhG6KAm3jCWrF9Lr9EL+
         vGQzFEbCuLJB1JIZB5wW9Toad5lr3jXRvPwCFRwWCUqA7ryJDvFomGQGRiMtKDHj3hvY
         p+ew==
X-Forwarded-Encrypted: i=1; AJvYcCXx2WRp+I1eq7UsnxrmjMrstX3lf3EGheevLKLiVviyRD+Xk/XGAJdOAHLBYCIIrg9nDEah55w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQ5x46y9ezq8GXzrlENi3IlhRlukh4Esr5Tuj0rWbz8f/2ZSQ
	zY6sMWvh+VScQFZxtm+yYvCiEyl029Ja1Jty+GvAtxkB3meN9g6N2HBzK79sz+Iv3jQ=
X-Gm-Gg: ASbGncuc4hvW/lZAxSrBF247RojcX23N7Y2/hrdqgtMXmawnC9sKjgwBePR96qWfFE9
	E5nzV24/aIhzo60qu/b6fDW5xwSQvLV/CPrvfXLDuKF5OP68B5/FsS6TNAqdQ0ODvhlib0Q4HXZ
	gBr5Iz08S3+LOQbKi4QoLfA45Lyb8kROpf/dyXVksenM//d8K24XbQlSjxU3sGqDjwOmv7G7v0S
	WZlE/ZBIHR6O9IO1GCOnHwlaHQ+5vbhaZCf1pgalD0gAKr9LtBlvKzNZZzagzsFnSSPOrBIN1D0
	LVqOM4r1eL+pYZ8/bH1S82+A8JdOXmodcSt8I1cbImhgZc8k2M2n0s3FiQSSJIH3Ov8puQ==
X-Google-Smtp-Source: AGHT+IEiaAkmOMcypoOLO4L/oIZCDDIOQyvPnmi1WnhS1JFkAvP/4z5JKzSCPRS/P9b0UTv0mlkU5w==
X-Received: by 2002:a05:6000:3c7:b0:3a5:287b:da02 with SMTP id ffacd0b85a97d-3b49702e849mr985133f8f.40.1751621521039;
        Fri, 04 Jul 2025 02:32:01 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470d9e470sm1977988f8f.41.2025.07.04.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 02:32:00 -0700 (PDT)
Date: Fri, 4 Jul 2025 11:31:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, david.kaplan@amd.com, dhowells@redhat.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v1 1/2] devlink: allow driver to freely name
 interfaces
Message-ID: <nbwrfnjhvrcduqzjl4a2jafnvvud6qsbxlvxaxilnryglf4j7r@btuqrimnfuly>
References: <20250703113022.1451223-1-jedrzej.jagielski@intel.com>
 <my4wiyu5dqlalt45e5pz2dfhjm3ytbnshhhjqlcdetp357z7u6@zvnq7wfcunlv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <my4wiyu5dqlalt45e5pz2dfhjm3ytbnshhhjqlcdetp357z7u6@zvnq7wfcunlv>

Fri, Jul 04, 2025 at 11:17:23AM +0200, jiri@resnulli.us wrote:
>Thu, Jul 03, 2025 at 01:30:21PM +0200, jedrzej.jagielski@intel.com wrote:
>>Currently when adding devlink port it is prohibited to let
>>a driver name an interface on its own. In some scenarios
>>it would not be preferable to provide such limitation.
>>
>>Remove triggering the warning when ndo_get_phys_port_name() is
>>implemented for driver which interface is about to get a devlink
>>port on.
>
>What's the reason for this? If you are missing some formatting, you
>should add it to devlink.
>
>Please don't to this.

I read the thread with the reported regression. Instead of this, could
you please perhaps rather add a flag to attrs:

struct devlink_port_attrs {
	u8 split:1,
	   splittable:1,
	   skip_phys_port_name_get:1; /* This is for compatibility only,
				       * newly added driver/port
				       * instance should never
				       * set this. */
Or something like that and check-return0 in
__devlink_port_phys_port_name_get()
?


>
>>
>>Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
>>---
>> net/devlink/port.c | 17 -----------------
>> 1 file changed, 17 deletions(-)
>>
>>diff --git a/net/devlink/port.c b/net/devlink/port.c
>>index 939081a0e615..f885c8e73307 100644
>>--- a/net/devlink/port.c
>>+++ b/net/devlink/port.c
>>@@ -1161,23 +1161,6 @@ static void devlink_port_type_netdev_checks(struct devlink_port *devlink_port,
>> {
>> 	const struct net_device_ops *ops = netdev->netdev_ops;
>> 
>>-	/* If driver registers devlink port, it should set devlink port
>>-	 * attributes accordingly so the compat functions are called
>>-	 * and the original ops are not used.
>>-	 */
>>-	if (ops->ndo_get_phys_port_name) {
>>-		/* Some drivers use the same set of ndos for netdevs
>>-		 * that have devlink_port registered and also for
>>-		 * those who don't. Make sure that ndo_get_phys_port_name
>>-		 * returns -EOPNOTSUPP here in case it is defined.
>>-		 * Warn if not.
>>-		 */
>>-		char name[IFNAMSIZ];
>>-		int err;
>>-
>>-		err = ops->ndo_get_phys_port_name(netdev, name, sizeof(name));
>>-		WARN_ON(err != -EOPNOTSUPP);
>>-	}
>> 	if (ops->ndo_get_port_parent_id) {
>> 		/* Some drivers use the same set of ndos for netdevs
>> 		 * that have devlink_port registered and also for
>>-- 
>>2.31.1
>>

