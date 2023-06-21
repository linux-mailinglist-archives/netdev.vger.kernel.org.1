Return-Path: <netdev+bounces-12855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69905739280
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF512816C5
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43E1D2CF;
	Wed, 21 Jun 2023 22:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62721C766
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EE1C433C0;
	Wed, 21 Jun 2023 22:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687386528;
	bh=eJQHRPYadnZhS6wrTj5pGIPcFnu125z2z1yWTAokULI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCj5tFDOQg7j/Y850yHM3NOlQrEj58+g85uCzNoE6a7t/zceaiFpYLnYoDhsE9CB8
	 AMa1PGHQe/sSp+wRFfduK2Mzza1mEv5+rLrvj+CVdJvMz4vwPuyJElhppDDr7uIsvU
	 o5heEvXXtc5inFiGQTP2tTeaMShHDASTj7QCjwHHwYwdMIHROkHJkZJwJyFl5N8Y+d
	 AJ8+vYlqqoNu3tCm0GxTTOPgZfRxphsw+VHRag5mZzyvcLObMHspPb8TtDeHZ8POv7
	 Ix00p4sD7MLt+ANKWHETFLwJdbRS6KgEQbCnNSctsqqAw7uDNiFkbKtbQGqC/+w281
	 aCfpLGppZ/eaQ==
Date: Wed, 21 Jun 2023 15:28:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Simon Horman
 <simon.horman@corigine.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 2/3] net: phy: phy_device: Call into the PHY
 driver to set LED offload
Message-ID: <20230621152846.4a5641f1@kernel.org>
In-Reply-To: <20230621152415.0bf552f3@kernel.org>
References: <20230619215703.4038619-1-andrew@lunn.ch>
	<20230619215703.4038619-3-andrew@lunn.ch>
	<20230621152415.0bf552f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 15:24:15 -0700 Jakub Kicinski wrote:
> On Mon, 19 Jun 2023 23:57:02 +0200 Andrew Lunn wrote:
> > +	/**
> > +	 * Can the HW support the given rules. Return 0 if yes,
> > +	 * -EOPNOTSUPP if not, or an error code.
> > +	 */
> > +	int (*led_hw_is_supported)(struct phy_device *dev, u8 index,
> > +				   unsigned long rules);
> > +	/**
> > +	 * Set the HW to control the LED as described by rules.
> > +	 */
> > +	int (*led_hw_control_set)(struct phy_device *dev, u8 index,
> > +				  unsigned long rules);
> > +	/**
> > +	 * Get the rules used to describe how the HW is currently
> > +	 * configure.
> > +	 */
> > +	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
> > +				  unsigned long *rules);  
> 
> Why not include @led_hw_control_get in the kernel doc?
> IIUC the problem is that the value doesn't get rendered when building
> documentation correctly, but that should get resolved sooner or later.
> 
> OTOH what this patch adds is not valid kdoc at all, and it will never 
> be valid, right?

I can't repro the issue with per-member docs, BTW:

/**
 * struct abc - a grocery struct
 * @a: give me an A
 */
struct abc {
	/** @c: C is problematic? */
	void (*c)(void);
	/**
	 * @d: maybe D then?
	 */
	void (*d)(int arg, struct device *s);
	int a;
	/** @b: give me a B */
	int b;
};

/**
 * struct zabka_ops - another grocery struct
 */
struct zabka_ops {
	/** @c: C is problematic? */
	void (*c)(void);
	/**
	 * @d: maybe D then?
	 */
	void (*d)(int arg, struct device *s);
};


$ ./scripts/kernel-doc test.h

.. c:struct:: abc

  a grocery struct

.. container:: kernelindent

  **Definition**::

    struct abc {
        void (*c)(void);
        void (*d)(int arg, struct device *s);
        int a;
        int b;
    };

  **Members**

  ``c``
    C is problematic? 

  ``d``
    maybe D then?

  ``a``
    give me an A

  ``b``
    give me a B 


.. c:struct:: zabka_ops

  another grocery struct

.. container:: kernelindent

  **Definition**::

    struct zabka_ops {
        void (*c)(void);
        void (*d)(int arg, struct device *s);
    };

  **Members**

  ``c``
    C is problematic? 

  ``d``
    maybe D then?




