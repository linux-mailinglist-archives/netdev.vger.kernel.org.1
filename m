Return-Path: <netdev+bounces-57256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD3812A46
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B351EB211D1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA5B171CC;
	Thu, 14 Dec 2023 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fdKvXply"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE0010F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:26:00 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so939129266b.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 00:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702542359; x=1703147159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buWSJcIpvPmRI/34AFOfrdGh6CJKqdnfchGxeEfGIrA=;
        b=fdKvXplyHIA3BMlkbqS+OhjSnvJ3zyEAq89e5PZx19JZVMJ6Tn+8qzCue4EU2ZNGwl
         F3B0/IzhrLXs3n8Tic/CUrh6FcMOXtO0OZVO26PpeDHM79mIDHwd8dyaC6JVyXvAwVIM
         s01iGYRmb7ZQqqhaYeV/Vks5HpuebBxbjfHmf39uEiSoZGNtgKFYP9hGg5iv3M+asMYW
         8LjqXfdMAQgdsDhwnLFElIYewb9qR3kNulsZvbSr1E7joSHsYYd97xwMbP4FbjUo2gzR
         JNuzpUMSR9uznBnuYl9eE6EDVj6a3oAW/BRo9Z/34sKy1Jv5HS7i1tzWS9Nb9oJ5gqQS
         4YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542359; x=1703147159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buWSJcIpvPmRI/34AFOfrdGh6CJKqdnfchGxeEfGIrA=;
        b=UEXykylI3kd9utNQcTNL5smDFLY8hXJr80yg2CeP2gKJbk5ApDo+77QNcmsFrxtaHP
         N4yL0EGBwMSREpkBRKyjTt+mzwAX2JT+GJrWwEe1dli673Zk9askI3RedIoXQ8nJsecj
         rhzd7f1GIxIiM2tBkQeTP67Oouq4p8jvsNYGuYDFKDcFa1tipWXm9k38eFXfXGt0q7t5
         z+gcD/8hCmSvQQTIDJ1zwRnwNXdJhaQBV+u+844qSmzq3B0Wi+tEMYPIDWwivSnl498d
         j4YB1XrPLa54jhDEA50QSnxhNo2YcZtL0ZqD7qc/xGKkYHfXLFxN4IPMp5CTDn2D5W8E
         gj8Q==
X-Gm-Message-State: AOJu0YwFtmm0h/4r/vnMDOtJZtOcJgqB8gIvCL0HxmVjgKQmPscLxM0l
	BdpHKvFsgxB7qVnMRUsH6vCIPg==
X-Google-Smtp-Source: AGHT+IEUiU+KoEvl94BKrmvng4P/8Q0+5zisWykkugDL1qNoOiDdSY3iCvuB+cKDOtw4G5eCYtBQZQ==
X-Received: by 2002:a17:906:6a18:b0:a19:a19b:55fc with SMTP id qw24-20020a1709066a1800b00a19a19b55fcmr5489070ejc.140.1702542358609;
        Thu, 14 Dec 2023 00:25:58 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id se21-20020a170907a39500b00a1f7f851607sm7626186ejc.197.2023.12.14.00.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:25:57 -0800 (PST)
Date: Thu, 14 Dec 2023 09:25:56 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [Draft PATCH net-next 1/3] Documentation: netlink: add a YAML
 spec for team
Message-ID: <ZXq8FIawPKUqcvk6@nanopsycho>
References: <20231213084502.4042718-1-liuhangbin@gmail.com>
 <20231213084502.4042718-2-liuhangbin@gmail.com>
 <ZXnPgIc4qdxJ0fvN@nanopsycho>
 <ZXp6CsaveeEPOVOm@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXp6CsaveeEPOVOm@Laptop-X1>

Thu, Dec 14, 2023 at 04:44:10AM CET, liuhangbin@gmail.com wrote:
>On Wed, Dec 13, 2023 at 04:36:32PM +0100, Jiri Pirko wrote:
>> >+operations:
>> >+  list:
>> >+    -
>> >+      name: noop
>> >+      doc: No operation
>> >+      value: 0
>> >+      attribute-set: team
>> >+      dont-validate: [ strict, dump ]
>> 
>> What is this good for?
>> 
>> 
>> >+
>> >+      do:
>> >+        # Actually it only reply the team netlink family
>> >+        reply:
>> >+          attributes:
>> >+            - team-ifindex
>> >+
>> >+    -
>> >+      name: options-set
>> >+      doc: Set team options
>> >+      attribute-set: team
>> >+      dont-validate: [ strict, dump ]
>> 
>> There is no dump op. Same below.
>> 
>Hi Jiri,
>
>I just copied this from the current team.c code. e.g.

Right, it is something which is not looked at. Remove it during the
conversion.

>
>static const struct genl_small_ops team_nl_ops[] = {
>        {
>                .cmd = TEAM_CMD_NOOP,
>                .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>                .doit = team_nl_cmd_noop,
>        },
>        {
>                .cmd = TEAM_CMD_OPTIONS_SET,
>                .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>                .doit = team_nl_cmd_options_set,
>                .flags = GENL_ADMIN_PERM,
>        },
>
>Do you want to remove all the GENL_DONT_VALIDATE_DUMP flags from team_nl_ops?
>
>Thanks
>Hangbin

