Return-Path: <netdev+bounces-165184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D9A30DD1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15D6165F7B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4824C693;
	Tue, 11 Feb 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jVeiDodI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2324C67A
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283038; cv=none; b=hizeiLmcyB7fODzoqQ9/XNKNmdFUcrx+udTac+utNY3vU6ygWWdh52Ii2ZFgBBFirCphZKgtSnIu+DOiWawU9bHtHRlMbuF+jdcUdXmxZU/yLxSKA/OSt5ZdOuk2qo2E5hzDfHoNNW1kDlXeRwyqvxN8W2ElSsJ1uDIx1WMRrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283038; c=relaxed/simple;
	bh=5W5xup3lNP2CSK84STN+QQKusQ4x/3YnJA2JuCFrCUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/K4Xz9iLhOJpfnRHqqoyo+BO0VwMQs7fZMGimOL7I44NX63xDUwh80BrONggCAUW1Dbg/njUewE5222EeYc0OAKKSjd0uJUIPFYp+zflxO4T8AOl1WsbNTMiZnGFhCYZjWbZrVrdvlyV2J2so2qLP1bbThG/A8QljIGVN98PWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jVeiDodI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4394a823036so15717955e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739283034; x=1739887834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/71oFHl6LCJTYVO3+NHeXZKQQaij+1df3d/jwlrGdU=;
        b=jVeiDodIxvygQ6iN+0mMbF45sFzvcdfopIvubctPcZvm40Bo6rXzNqHgm7T7V8ArWg
         qTbsXvhVNmR4lmfi0tmjHQVJVP7OV+zADBD24JR1U0zsLoSEBCuIQ445msy9Nnm+xyMT
         V44UzTTkriYZXejUNAW9ocryq56guFSovKx5Ny6LmMaVoBnEKWfJGxOvy8gbIo3+FABN
         5CVhn/qBtKmts6LmElm1ND3w6LCTWv8UhJ1lZGTLDIYOSe2bxUvYar8lW0lL46WUJtDI
         LFeauRyui+jANNKQsu/e8AaB35bZkceZ7lfdIpHz3ojRwvWABtvy47uDqJZWpk1XTW69
         kQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739283034; x=1739887834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/71oFHl6LCJTYVO3+NHeXZKQQaij+1df3d/jwlrGdU=;
        b=FOzNRqqNWFVwtY2I+ol9iVVDwLIFqoz+hkLIiWrGQ43Y+AX8IbXDmcrAPoiSXoGODS
         /SDjKy7lXDaG7mXbAAWNgDtT5nPlrH3xc9OU1eGCDhTxBfXkenlBQe2iJ6M0BGavgc8v
         YGGVrTasb/nGzlHvvRWzdp8fkDn0w3CDl+I2Rjz7t/M0L+uqlEXqhBpwSJfpEglgwlf/
         JOvgL1S6DHn/ru43MyjEV2IfwBtTkeIlnh5G+2pJSgOfB7urHBYS8XYlRw/asT5hS+ov
         SvYGsB3hgh8TWYGu44dUXMxIu38HdFlY+DPbSBrTZw80StVm9hIU9+Set8ryhwEhKPL1
         UwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr9aTfrieqQ4C2tZiLTAIG2YzwQmlWqvpL3hTNC7BUBgoQAG9b2VxigvzZ8AiuC4N0BBiFcuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/Cjy6DxqvguKcALDJMDN6H6S7cc4FgjOtDiiJKzkx+IzuK4Z
	qs9foddbVpX+7n6iq8NfvIm+pay77z+3mmZlPWHNMvjxl0yAv5H0Pglv/v1ajsM=
X-Gm-Gg: ASbGnctItLdQHTsw4fqhw6N9906cqAx/W5m5Y20TH9VI1ozsRAgiAJs2mLyrbvl8JlM
	8JrWTCGscf5OZY49ZkkAAy+881wR0FKGGeFcgrHwVK6yLw1sXb08RrmeHtIeTzMu4UbFvb0Wsdx
	z7epWWLR99lm84oh18BJs0mR5CR399QMsYbrBFt92fL5xI+lkHNllOPcD3aK9S38jona0pwK6WC
	dZo3hBkR8TiPRJhUBWR/WGs9DqYfk9WBwzT1IGe8xZ7hB8B1mh8uqQLkCUYP9YOooijiOYa5s29
	ITxyN8xY1hcMonW5+pAThbM=
X-Google-Smtp-Source: AGHT+IF1vYt631Ryp+ngh2LL7KD/8xmGp8x6eOLbxO8BpEt9prwfOZpt9KGoqqhzeN0LQjF6BfSPHQ==
X-Received: by 2002:a05:600c:1ca1:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439557395d5mr17853285e9.22.1739283034150;
        Tue, 11 Feb 2025 06:10:34 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dcb43basm10502335e9.2.2025.02.11.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:10:33 -0800 (PST)
Date: Tue, 11 Feb 2025 15:10:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, "Knitter, Konrad" <konrad.knitter@intel.com>, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, wojciech.drewek@intel.com, mateusz.polchlopek@intel.com, 
	joe@perches.com, horms@kernel.org, apw@canonical.com, lukas.bulwahn@gmail.com, 
	dwaipayanray1@gmail.com, Igor Bagnucki <igor.bagnucki@intel.com>, 
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 6/7] ice: dump ethtool stats and skb by Tx hang
 devlink health reporter
Message-ID: <xqcscv23ggjuq5khxuudu572ru56c5v4gyd4uvjjky27vgtopq@gzleriv56yah>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
 <20241211223231.397203-7-anthony.l.nguyen@intel.com>
 <20241212190040.3b99b7af@kernel.org>
 <2a71791c-a73a-4a3c-8573-7b80d1c39d57@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a71791c-a73a-4a3c-8573-7b80d1c39d57@intel.com>

Mon, Dec 16, 2024 at 05:53:03AM +0100, przemyslaw.kitszel@intel.com wrote:
>On 12/13/24 04:00, Jakub Kicinski wrote:
>> On Wed, 11 Dec 2024 14:32:14 -0800 Tony Nguyen wrote:
>> > From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> > 
>> > Print the ethtool stats and skb diagnostic information as part of Tx hang
>> > devlink health dump.
>> > 
>> > Move the declarations of ethtool functions that devlink health uses out
>> > to a new file: ice_ethtool_common.h
>> > 
>> > To utilize our existing ethtool code in this context, convert it to
>> > non-static.
>> 
>> This is going too far, user space is fully capable of capturing this
>> data. It gets a netlink notification when health reporter flips to
>> a bad state.
>
>It really pays to split your patches into trivial vs controversial ones.
>
>Will it be fine to merge this series without patch 6 (and 3) then?
>Patches 2, 4 and 5 are dependency for another health reporters that
>Konrad did:
>https://lore.kernel.org/intel-wired-lan/20241211110357.196167-1-konrad.knitter@intel.com
>
>> I think Jiri worked on a daemon what could capture more
>> data from user space ? I may be misremembering...
>
>We would love to read more on that, then with more knowledge revisit
>what to do about our needs covered by this patch.

I will keep you in loop. Working on devlinkd as a part of systemd. Will
cc you for the initial rfc.

